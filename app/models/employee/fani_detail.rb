class Employee::FaniDetail < ApplicationRecord
  belongs_to :employee_fanis
  belongs_to :furniture_build_details
end
