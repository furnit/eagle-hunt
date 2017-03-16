class Picture < ApplicationRecord
  include Rails.application.routes.url_helpers
  mount_uploaders :images, ImageUploader
  
  def to_jq_upload
    {
      "name" => read_attribute(:images),
      "url" => images[0].url,
      "thumbnail_url" => images[0].thumb.url,
      "delete_url" => pictures_path(:id => id),
      "delete_type" => "DELETE" 
    }
  end
end
