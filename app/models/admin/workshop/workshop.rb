class Admin::Workshop::Workshop < ApplicationRecord
  belongs_to :state
  belongs_to :manager, class_name: '::User', foreign_key: :user_id
  
  has_many :transits, class_name: '::Admin::Pricing::Transit', foreign_key: :admin_workshop_workshop_id
  
  validates_presence_of :name, :address, :phone_number, :manager, :state
  validates_uniqueness_of :name
  
  validates :phone_number, length: { is: 11 }, uniqueness: true
  validates_format_of :phone_number, with: /\A0\d{10}\z/i, message: :invalid

  after_initialize  { self.phone_number = normalize_phone_number self.phone_number }
  before_validation { self.phone_number = normalize_phone_number self.phone_number } 
end
