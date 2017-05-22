class Employee::Fani < Employee::FurnitureBuildRelatedModel
  def build_details
    Admin::Furniture::BuildDetail.where(id: Employee::FanisFurnitureBuildDetails.where(employee_fani_id: self.id).pluck(:admin_furniture_build_detail_id))
  end

  validates_presence_of :wage_rokob, :wage_khayat, :days_to_complete

  # delete the associated build details
  before_destroy { build_details.each(&:destroy) }
end
