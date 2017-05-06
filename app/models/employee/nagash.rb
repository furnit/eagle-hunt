class Employee::Nagash < Employee::FurnitureBuildRelatedModel
  validates_presence_of :wage, :astare_avaliye, :astare_asli, :range_asli, :rouye, :days_to_complete
end
