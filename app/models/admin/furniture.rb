class Admin::Furniture < ParanoiaRecord
    
  belongs_to :furniture_type, class_name: 'Admin::FurnitureType', foreign_key: :furniture_type_id

  validates_presence_of :furniture_type_id, :name
  
  mount_uploaders :images,        ImageUploader

  # don't delete the images on soft delete
  # see: (github.com/carrierwaveuploader/carrierwave/issues/624#issuecomment-15243440)
  skip_callback :commit, :after, :remove_images!
  
  def cost?
    return 1e+6
  end

  def save
	# default values for cover details
    self.cover_details ||= {index: 0, pos: '50%'}
    super
  end
  
  filterrific(
    default_filter_params: { sorted_by: 'updated_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :get_by_furniture_types,
    ]
  )
  
  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
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
          "LOWER(admin_furnitures.name) LIKE ?",
          "LOWER(admin_furnitures.comment) LIKE ?",
          "LOWER(admin_furnitures.description) LIKE ?"
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
      order("admin_furnitures.updated_at #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      ['زمان بروزرسانی (جدیدترین در ابتدا)', 'updated_at_desc'],
      ['زمان بروزرسانی (قدیمی‌ترین در ابتدا)', 'updated_at_asc']
    ]
  end
end
