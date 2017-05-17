class Admin::Furniture::Furniture < ParanoiaRecord
  has_many :employee_fanis, dependent: :destroy, class_name: '::Employee::Fani'
  has_one :overall_details, class_name: '::Employee::Overall', foreign_key: :admin_furniture_furniture_id
  has_one :price, class_name: '::Admin::Selling::Config::Price', foreign_key: :admin_furniture_furniture_id
  belongs_to :type, class_name: '::Admin::Furniture::Type', foreign_key: :furniture_type_id
  
  accepts_nested_attributes_for :employee_fanis, :allow_destroy => true

  validates_presence_of :furniture_type_id, :name
  
  validates :free_cushions, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 20 } 
  
  mount_uploaders :images, ImageUploader

  # don't delete the images on soft delete
  # see: (github.com/carrierwaveuploader/carrierwave/issues/624#issuecomment-15243440)
  skip_callback :commit, :after, :remove_images!
  
  before_save :notify_on_availble
  
  def comment= val
    self[:comment] = val[0..(self.class.columns_hash['comment'].limit-1)]
  end
  
  def available= val
    if not val
      self[:available] = val
    else
      raise ClientError.new('داده‌های مالی یا فنی لازم جهت قابل سفارش شدن این محصول وجود ندارد.') if [self[:has_unconfirmed_data], not(self[:ready_for_pricing]), self.cost? <= 0].any?
      self[:available] = val
    end
  end
  
  def has_unconfirmed_data= val
    self[:has_unconfirmed_data] = val
    if val
      self[:available] = false
      self[:ready_for_pricing] = false
    end
  end
  
  def cost?
    _profit = Admin::Selling::Config::Profit.last;
    _price  = self.price 
    return 0 if [_profit.nil?, _price.nil?, (_price and _price.overall_cost.nil?), not(self.ready_for_pricing)].any?
    ((1 + (_profit.overall / 100.0)) * _price.overall_cost).to_i
  end
  
  
  def compute_cost const: nil, fabric: nil, paint_color: nil, paint_astar_rouye: nil, wood: nil, kalaf: nil
    # fetch all foams' prices
    foam = Admin::Pricing::Foam.all
    # validate pricing of foams
    raise ClientError.new("ابر قیمت‌گذاری نشده است.") if foam.empty?
    # validate const prices
    raise ClientError.new("هزینه‌های ثابت قیمت‌گذاری نشده است.") if not const
    # validate kalaf prices
    raise ClientError.new("کلاف قیمت‌گذاری نشده است.") if not kalaf
    # overall details
    od   = overall_details.as_json
    # general details
    gd   = od.reject { |i| [:id, :admin_furniture_furniture_id, :created_at, :updated_at].include? i.to_sym or i =~ /.*(wage|needs|days_to_complete|build_details).*/ };
    # define sum
    sum = 0
    # sum-up consts
    sum = const.as_json.reject { |i| [:id, :updated_at, :created_at].include? i.to_sym }.sum if const
    # sum-up wages
    sum += od.select { |i| i =~ /.*wage.*/}.sum
    # sum-up najar
    sum += gd[:najar_choob.to_s] * wood.price if wood and gd[:najar_choob.to_s]
    # sum-up kalaf
    sum += gd[:kalaf_choob.to_s] * kalaf.price if kalaf and gd[:kalaf_choob.to_s]
    # sum-up paint-color
    sum += gd[:nagash_range_asli.to_s] * paint_color.price if paint_color and gd[:nagash_range_asli.to_s]
    # if astar va rouye given?
    if paint_astar_rouye
      # compute astar va rouye
      paint_astar_rouye.as_json.select { |x| not [:id, :created_at, :updated_at].include? x.to_sym }.each do |f, v|
        if gd["nagash_#{f}"]
          sum += (gd["nagash_#{f}"] * v)
        else
          sum += v
        end
      end
    end
    # sum-up build details
    od[:fani_build_details.to_s].each do |d|
      price = 0
      # convert from hash to furniture build details
      ins = FurnitureBuildDetail.new(d)
      case ins.spec.name
      when 'ابر'
        price = foam.select { |i| i.admin_furniture_foam_type_id == ins.options["admin_furniture_foam_types"]["id"].to_i }.first.price
      when 'پارچه'
        price = fabric.price if fabric
      else
        raise RuntimeError.new("undefined spec# #{ins.spec.id}")
      end
      sum += price * ins.value
    end
    # round-up the sum and return the value
    sum.stepize AppConfig.preference.price.round
  end

  def save
	# default values for cover details
    self.cover_details ||= {index: 0, pos: '50%'}
    super
  end
  
  def notify_on_availble
    ::NotifyOnFurnitureAvailable.notify_for_furniture self.id, self.name if self.available and self.available_changed?
  end
  
  def intel
    intel = { }
    ::Employee::Processed.where(admin_furniture_id: self.id).distinct.each do |proc|
      name = proc.as_symbol.downcase.to_sym
      intel[name] ||= []
      intel[name] << {
        meta: proc,
        data: "Employee::#{proc.as_symbol.to_s.downcase.classify}".constantize.where(furniture_id: self.id, user_id: proc.user_id).last
      }
    end
    intel
  end
  
  def ready_for_pricing= val
    self[:ready_for_pricing] = val
    
    if self[:ready_for_pricing]
      overalls = { }
      self.intel.each do |name, i|
        next if i.empty?
        data = i.map { |ii| ii[:data] }
        (::Employee::Overall.column_names & data.first.as_json.keys.map { |ii| "#{name.to_s.downcase}_#{ii}" }).each do |column|
          tabc = column.gsub("#{name.to_s.downcase}_", "")
          overalls[column] = data.max_by { |ii| ii[tabc].to_f }[tabc]
        end
      end
      overalls[:fani_build_details] = []
      fbd = { }
      self.intel[:fani].each do |i|
        i[:data].furniture_build_details.each do |bd|
          key = "#{bd.admin_furniture_section_id}-#{bd.admin_furniture_spec_id}"
          fbd[key] ||= []
          fbd[key] << bd
        end
      end
      fbd.each do |_, i|
        overalls[:fani_build_details] << i.max_by { |ii| ii.value }
      end
      ::Employee::Overall.find_or_create_by(admin_furniture_furniture_id: self.id).update_attributes(overalls)
    end
  end
  
  def days_to_complete
    overall = ::Employee::Overall.where(admin_furniture_furniture_id: self.id).first
    return -1 if overall.nil?
    conf = Admin::Selling::Config::DaysToComplete.last
    extra = 0
    extra = conf.as_json.reject { |k| [:id, :created_at, :updated_at].include? k.to_sym }.sum if conf
    (overall.as_json.select { |c| c[/\w+_days_to_complete$/] }.values.sum + extra).to_i
  end
  
  filterrific(
    default_filter_params: { sorted_by: 'updated_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :get_by_furniture_types,
      :get_by_flags
    ]
  )
  
  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 3
    where(
      terms.map {
        or_clauses = [
          "LOWER(admin_furniture_furnitures.name) LIKE ?",
          "LOWER(admin_furniture_furnitures.comment) LIKE ?",
          "LOWER(admin_furniture_furnitures.description) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }
  
  scope :get_by_furniture_types, lambda { |f_type_id|
    where("furniture_type_id = ?", f_type_id)
  }
  
  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^updated_at_/
      order("admin_furniture_furnitures.updated_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :get_by_flags, lambda { |flag_id|
    case get_flags.map { |i| i[:column] }[flag_id]
    when 'has_unconfirmed_data'
      where('has_unconfirmed_data')
    when 'ready_for_pricing'
      where('ready_for_pricing')
    when 'not_ready_for_pricing'
      where('not ready_for_pricing')
    when 'priced'
      where("id IN (?) and ready_for_pricing", Admin::Selling::Config::Price.pluck(:admin_furniture_furniture_id))
    when 'not_priced'
      where("id NOT IN (?) or not ready_for_pricing", Admin::Selling::Config::Price.pluck(:admin_furniture_furniture_id))
    when 'data_locked_at'
      where('data_locked_at IS NOT NULL')
    when 'not_data_locked_at'
      where('data_locked_at IS NULL')
    when 'available'
      where('available')
    when 'not_available'
      where('not available')
    else
      raise RuntimeError.new('undefined flag')
    end
  }

  def self.get_flags
    [
      { column: 'has_unconfirmed_data', title: 'حاوی اطلاعات تایید نشده', data: { content: "<span class='fa fa-info' style='padding-top: 10px'></span> حاوی اطلاعات تایید نشده" } },
      { column: 'ready_for_pricing', title: 'آماده برای قیمت‌گذاری', data: { content: "<span class='fa fa-money' style='padding-top: 10px'></span> آماده برای قیمت‌گذاری" } },
      { column: 'not_ready_for_pricing', title: 'حاوی اطلاعات ناقص', data: { content: "<span class='fa fa-ban' style='padding-top: 10px'></span> حاوی اطلاعات ناقص" } },
      { column: 'priced', title: 'دارای قیمت', data: { content: "<span class='fa fa-money text-success' style='padding-top: 10px'></span> دارای قیمت" } },
      { column: 'not_priced', title: 'قیمت‌گذاری نشده', data: { content: "<span class='fa fa-money text-danger' style='padding-top: 10px'></span> قیمت‌گذاری نشده" } },
      { column: 'data_locked_at', title: 'اطلاعات قفل شده', data: { content: "<span class='fa fa-lock' style='padding-top: 10px'></span> اطلاعات قفل شده" } },
      { column: 'not_data_locked_at', title: 'اطلاعات قفل نشده', data: { content: "<span class='fa fa-unlock-alt' style='padding-top: 10px'></span> اطلاعات قفل نشده" } },
      { column: 'available', title: 'قابل سفارش', data: { content: "<span class='fa fa-check' style='padding-top: 10px'></span> قابل سفارش" } },
      { column: 'not_available', title: 'غیر قابل سفارش', data: { content: "<span class='fa fa-times' style='padding-top: 10px'></span> غیرقابل سفارش" } }
    ]
  end

  def self.options_for_sorted_by
    [
      ['زمان بروزرسانی (جدیدترین در ابتدا)', 'updated_at_desc'],
      ['زمان بروزرسانی (قدیمی‌ترین در ابتدا)', 'updated_at_asc']
    ]
  end
end
