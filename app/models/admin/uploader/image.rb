class Admin::Uploader::Image < ApplicationRecord
  self.abstract_class = true
  
  after_save :flag_owned

  after_initialize { self[:images] ||= [] }
  
  def images= val
    self[:images] = [val].flatten
  end
  
  def images
    Admin::UploadedFile.where(id: self[:images]).map { |i| { id: i.id, image: i.image } }.flatten
  end
  
  def image= val
    self[:images] = [[val].flatten.first]
  end
  
  def image
    i = Admin::UploadedFile.where(id: self[:images]).first
    { id: i.id, image: i.image }
  end
  
  def append_images val
    self[:images] += [val].flatten
  end
  
  def remove_images val
    val = [val].flatten
    Admin::UploadedFile.where(id: val).each(&:destroy)
    self[:images] -= val
  end
  
  def secure_image_id id
    "#{id}?#{get_hash id.to_s}"
  end
  
  def image_id? secure_id
    s = secure_id.split("?")
    raise ActiveRecord::RecordNotFound.new("image not found!") if s.length != 2 or not(s[0].numeric?) or s[1] != get_hash(s[0])
    s[0].to_i
  end
  
  private
  
    def flag_owned
      return if not self.images_changed?
      Admin::UploadedFile.where(id: self[:images]).update_all(owned: true);
    end
end
