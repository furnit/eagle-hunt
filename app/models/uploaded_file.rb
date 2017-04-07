class UploadedFile < ApplicationRecord
  include Rails.application.routes.url_helpers
  mount_uploaders :images, ImageUploader
  
  def to_jq_upload
    out = [];
    images.each.with_index do |image, index|
      out << {
        :id => id,
        :index => index,
        :name => read_attribute(:images)[index],
        :url => image.url,
        :thumbnail_url => image.thumb.url,
        :delete_url => uploaded_file_path(self)
      }
    end
    return out
  end
end
