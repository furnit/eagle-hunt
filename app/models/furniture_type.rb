class FurnitureType < ApplicationRecord
  has_many :furniture
  mount_uploaders :images, ImageUploader
  
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
