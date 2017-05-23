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

  before_save { self[:images].uniq! }

  after_initialize { self[:images] ||= []; @new_images = [] }
  
  after_destroy { Admin::UploadedFile.where(id: self[:images]).each(&:destroy) }
  
  def images= val
    val = validate_images val
    # flag not owned the previous images that are not included in `val`
    flag_not_owned self[:images] - (self[:images] & val)
    # reset the images 
    self[:images] = val
    # flag the new images
    @new_images = val.uniq
  end
  
  def image= val
    val = validate_images val
    # flag not owned the previous images that are not included in `val`
    flag_not_owned self[:images] - (self[:images] & val)
    raise RuntimeError.new("cannot accept more than 1 image file, but #{val.length} given") if val.length > 1
    # reset the images
    self[:images] = val
    # flag the new images
    @new_images = val.uniq
  end
  
  def append_images val
    val = validate_images val
    # flag the new images
    flag_new_images val
    # add to the list
    self[:images] = (self[:images] + val).uniq
  end
  
  def remove_images val
    val = validate_images val
    # only remove the images that are bound to current instance
    return if val.empty? or (self[:images] & val).empty?
    # flag not owned the images
    flag_not_owned (self[:images] & val)
    # remove from the list
    self[:images] -= val
  end
  
  def images
    Admin::UploadedFile.where(id: self[:images]).map { |i| { id: i.id, image: i.image } }.flatten
  end
  
  def image
    i = Admin::UploadedFile.where(id: self[:images]).first
    { id: i.id, image: i.image }
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
  
    def validate_images val
      _val = [val].flatten
      idx = Admin::UploadedFile.where(id: _val).pluck(:id)
      raise ActiveRecord::RecordNotFound.new("images `#{_val - idx}` does not exists") if idx.map(&:to_i).sort != _val.map(&:to_i).sort
      idx.uniq
    end
    
    def flag_new_images val
      val = [val].flatten
      # only add those that are not included in current images' list
      @new_images = (@new_images + (val - (self[:images] & val))).uniq
    end
      
    
    def flag_not_owned val
      idx = (self[:images] & val)
      return if idx.empty?
      # remove from new image lists
      @new_images -= idx
      # decrement the owned flag
      Admin::UploadedFile.where(id: idx).update_all("owned = owned - 1");
      # destroy the image if no one referencing this
      Admin::UploadedFile.where(id: idx).where("owned <= 0").each(&:destroy)
    end
    
    def flag_owned
      return if not self.images_changed? or @new_images.empty?
      # only own the new images
      Admin::UploadedFile.where(id: @new_images).update_all("owned = owned + 1");
    end
end
