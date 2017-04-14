class Employee::Processed < ApplicationRecord
  belongs_to :furniture
  belongs_to :user
  
  
  validates :admin_furniture_id, uniqueness: { scope: :user_id }
end
