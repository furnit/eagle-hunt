class CreateAdminFurnitureWoodColorWeights < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_wood_color_weights do |t|
      t.string :name
      t.text :comment

      t.timestamps
    end
  end
end
