class CreateAdminFurnitureFabricCushions < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_fabric_cushions do |t|
      t.string :label
      t.integer :width
      t.integer :height
      t.text :comment

      t.timestamps
    end
  end
end
