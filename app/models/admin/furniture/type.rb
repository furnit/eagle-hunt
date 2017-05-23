class Admin::Furniture::Type < Admin::Uploader::Image
  
  acts_as_paranoid
  
  has_many :furniture, class_name: '::Admin::Furniture::Furniture', foreign_key: :furniture_type_id
  
  validates_presence_of :name, :comment
  
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
