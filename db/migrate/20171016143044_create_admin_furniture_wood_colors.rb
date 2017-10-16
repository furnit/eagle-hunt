class CreateAdminFurnitureWoodColors < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_wood_colors do |t|
      t.string :name
      t.string :value
      t.text :comment

      t.timestamps
    end
  end
end
