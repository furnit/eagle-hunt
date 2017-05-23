class Admin::Furniture::Section < Admin::Uploader::Image
  validates_presence_of :name, :comment, :tag
end
