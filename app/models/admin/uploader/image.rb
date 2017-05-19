class Admin::Uploader::Image < ApplicationRecord
  self.abstract_class = true
  
  after_save :flag_owned
  
  scope :select_by_image, -> (id) { find_by_images([id].flatten.first).first }
  
  scope :select_by_images, -> (*ids) { 
    ids = ids.flatten
    next none if ids.empty?
    if not ids.map { |idx| idx.to_s.numeric? }.all?
      if ids.map { |idx|  idx =~ /^\d+\?[0-9a-z]+$/i }.all?
        ids = ids.map { |idx| image_id? idx }
      else
        raise RuntimeError.new("invalid image id!")
      end
    end
    where(ids.flatten.map { |id| "JSON_CONTAINS(images, ?)" }.join(" OR "), *ids.flatten.map(&:to_s))
  }

  after_initialize { self[:images] ||= [] }
  
  after_destroy { Admin::UploadedFile.where(id: self[:images]).each(&:destroy) }
  
  def images= val
    _val = [val].flatten
    idx = Admin::UploadedFile.where(id: _val.first).pluck(:id)
    raise ActiveRecord::RecordNotFound.new("images `#{_val - idx}` does not exists") if idx.map(&:to_i).sort != _val.map(&:to_i).sort
    self[:images] = idx
  end
  
  def images
    Admin::UploadedFile.where(id: self[:images]).map { |i| { id: i.id, image: i.image } }.flatten
  end
  
  def image= val
    _val = [val].flatten
    raise RuntimeError.new("cannot accept more than 1 image file, but #{_val.length} given") if _val.length > 1
    idx = Admin::UploadedFile.where(id: _val.first).pluck(:id)
    raise ActiveRecord::RecordNotFound.new("images `#{_val - idx}` does not exists") if idx.map(&:to_i).sort != _val.map(&:to_i).sort
    self[:images] = idx
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
  
  def self.secure_image_id id
    "#{id}?#{get_hash id.to_s}"
  end
  
  def self.image_id? secure_id
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
