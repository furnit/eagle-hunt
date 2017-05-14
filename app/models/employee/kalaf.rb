class Employee::Kalaf < Employee::FurnitureBuildRelatedModel
  validates_presence_of :wage, :choob, :days_to_complete
end
