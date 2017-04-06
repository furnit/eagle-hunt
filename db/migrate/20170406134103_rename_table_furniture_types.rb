class RenameTableFurnitureTypes < ActiveRecord::Migration[5.0]
  def change
  	rename_table :furniture_types, :admin_furniture_types
  end
end
