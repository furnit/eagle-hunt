class Admin::Furniture::Furniture < ParanoiaRecord
  has_many :employee_fanis, dependent: :destroy, class_name: '::Employee::Fani'
  has_one :overall_details, class_name: '::Employee::Overall', foreign_key: :admin_furniture_furniture_id
  belongs_to :type, class_name: '::Admin::Furniture::Type', foreign_key: :furniture_type_id
  
  accepts_nested_attributes_for :employee_fanis, :allow_destroy => true

  validates_presence_of :furniture_type_id, :name
  
  validates :free_cushions, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 20 } 
  
  mount_uploaders :images,        ImageUploader

  # don't delete the images on soft delete
  # see: (github.com/carrierwaveuploader/carrierwave/issues/624#issuecomment-15243440)
  skip_callback :commit, :after, :remove_images!
  
  before_save :notify_on_availble
  
  def cost?
    return 1e+6
  end
  
  def compute_cost fabric: nil, paint_color: nil, wood: nil, kalaf: nil
    foam = Admin::Pricing::Foam.all
    # overall details
    od   = overall_details.as_json
    # general details
    gd   = od.reject { |i| [:id, :admin_furniture_furniture_id, :created_at, :updated_at].include? i.to_sym or i =~ /.*(wage|needs|days_to_complete|build_details).*/ };
    # sum-up wages
    sum  = od.select { |i| i =~ /.*wage.*/}.sum
    # sum-up najar
    sum += gd[:najar_choob.to_s] * wood.price if wood
    # sum-up kalaf
    sum += gd[:kalaf_choob.to_s] * kalaf.price if kalaf
    byebug
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
    sum
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
    overall.as_json.select { |c| c[/\w+_days_to_complete$/] }.values.sum
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
