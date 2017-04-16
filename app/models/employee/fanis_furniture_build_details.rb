class Employee::FanisFurnitureBuildDetails < ApplicationRecord
  belongs_to :employee_fanis, class_name: '::Employee::Fani'
  belongs_to :furniture_build_details, class_name: '::FurnitureBuildDetail'
end
