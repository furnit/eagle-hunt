class CreateAdminFurnitureColors < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_colors do |t|
      t.string :name
      
      t.references :admin_furniture_color_qualities, foreign_key: true, index: { name: "index_color_quality" }
      t.references :admin_furniture_color_brands, foreign_key: true, index: { name: "index_color_brand" }
      
      t.text :comment
      t.string :color_value
      t.json :color_details

      t.timestamps
    end
  end
end
