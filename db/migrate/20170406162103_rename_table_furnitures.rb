class RenameTableFurnitures < ActiveRecord::Migration[5.0]
  def change
  	rename_table :furnitures, :admin_furnitures
  end
end
