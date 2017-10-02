class AddAvailableToAdminFurnitureFabricFabrics < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_furniture_fabric_brands, :available, :boolean, default: false
  end
end
