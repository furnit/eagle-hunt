class EmployeeProcessed < ApplicationRecord
  belongs_to :furniture
  belongs_to :user
end
