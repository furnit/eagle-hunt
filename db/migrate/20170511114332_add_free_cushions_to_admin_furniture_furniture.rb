class AddFreeCushionsToAdminFurnitureFurniture < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_furniture_furnitures, :free_cushions, :integer, default: 0
  end
end
