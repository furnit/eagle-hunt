class Furniture < ApplicationRecord
  acts_as_paranoid
  
  has_many :furniture_set
  belongs_to :furniture_type
  has_many :sitting_set, through: :furniture_set

  validates_presence_of :furniture_type, :name, :images
  mount_uploaders :images, ImageUploader
  
  def cost?
    return 1e+6
  end
  
end
