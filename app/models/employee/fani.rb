class Employee::Fani < Employee::FurnitureBuildRelatedModel
  has_and_belongs_to_many :furniture_build_details, class_name: '::FurnitureBuildDetail', foreign_key: :employee_fani_id

  validates_presence_of :wage_rokob, :wage_khayat, :days_to_complete
  
  # delete the associated build details
  before_destroy { furniture_build_details.each(&:destroy) }
end
