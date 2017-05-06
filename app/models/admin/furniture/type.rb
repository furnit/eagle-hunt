class Admin::Furniture::Type < ParanoiaRecord
  
  has_many :furniture, class_name: '::Admin::Furniture::Furniture', foreign_key: :furniture_type_id
  
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
end
