class Employee::Processed < ApplicationRecord
  belongs_to :furniture
  belongs_to :user
  
  validates_uniqueness_of :admin_furniture_id, scope: [:user_id, :as_symbol]
end
