class RenameAdminFurnitureFabricTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :admin_furniture_fabrics, :admin_furniture_fabric_fabrics
  end
end
