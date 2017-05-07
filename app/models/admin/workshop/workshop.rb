class Admin::Workshop::Workshop < ApplicationRecord
  belongs_to :state
  belongs_to :manager, class_name: '::User', foreign_key: :user_id
  
  validates_presence_of :name, :address, :phone_number, :user_id, :state_id
  validates_uniqueness_of :name
end
