class Admin::UploadedFile < ApplicationRecord
  include Rails.application.routes.url_helpers
  mount_uploader :image, ImageUploader
  
  def to_jq_upload
    [
      {
        :id => id,
        :index => 0,
        :name => read_attribute(:image),
        :url => image.url,
        :thumbnail_url => image.thumb.url,
        :delete_url => admin_uploaded_file_path(self)
      }
    ]
  end
end
