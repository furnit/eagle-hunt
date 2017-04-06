class Admin::FurnitureType < ParanoiaRecord
  
  has_many :furniture
  
  validates_presence_of :name
  
  mount_uploaders :images, ImageUploader
  # don't delete the images on soft delete
  # see: (github.com/carrierwaveuploader/carrierwave/issues/624#issuecomment-15243440)
  skip_callback :commit, :after, :remove_images!
  
  def to_jq_upload
    {
      "name" => read_attribute(:images),
      "size" => image.size,
      "url" => image.url,
      "thumbnail_url" => image.thumb.url,
      "delete_url" => id,
      "picture_id" => id,
      "delete_type" => "DELETE"
    }
  end
  
  filterrific(
    default_filter_params: { sorted_by: 'updated_at_desc' },
    available_filters: [
      :sorted_by
    ]
  )
  
  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^updated_at_/
      order("admin_furniture_types.updated_at #{ direction }")
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
