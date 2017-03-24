class Furniture < ParanoiaRecord
    
  belongs_to :furniture_type

  validates_presence_of :furniture_type, :name
  
  mount_uploaders :images,        ImageUploader
  mount_uploader  :image_profile, ImageUploader
  # don't delete the images on soft delete
  # see: (github.com/carrierwaveuploader/carrierwave/issues/624#issuecomment-15243440)
  skip_callback :commit, :after, :remove_images!
  
  def cost?
    return 1e+6
  end
  
end
