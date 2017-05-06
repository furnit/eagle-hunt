class RenameAdminFurnitureTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :admin_furnitures, :admin_furniture_furnitures
  end
end
