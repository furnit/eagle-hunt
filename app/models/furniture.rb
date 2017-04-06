class Furniture < ParanoiaRecord
    
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
  
end
