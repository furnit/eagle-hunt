class Admin::Furniture::Furniture < ParanoiaRecord
  has_many :employee_fanis, dependent: :destroy, class_name: '::Employee::Fani'
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

  def save
	# default values for cover details
    self.cover_details ||= {index: 0, pos: '50%'}
    super
  end
  
  def notify_on_availble
    NotifyOnFurnitureAvailable.notify_for_furniture self.id, self.name if self.available and self.available_changed?
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
      { column: 'has_unconfirmed_data', title: 'حاوی اطلاعات تایید نشده' },
      { column: 'data_locked_at', title: 'اطلاعات قفل شده' },
      { column: 'not_data_locked_at', title: 'اطلاعات قفل نشده' },
      { column: 'available', title: 'قابل سفارش' },
      { column: 'not_available', title: 'غیر قابل سفارش' }
    ]
  end

  def self.options_for_sorted_by
    [
      ['زمان بروزرسانی (جدیدترین در ابتدا)', 'updated_at_desc'],
      ['زمان بروزرسانی (قدیمی‌ترین در ابتدا)', 'updated_at_asc']
    ]
  end
end
