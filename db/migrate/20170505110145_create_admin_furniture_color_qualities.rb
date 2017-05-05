class CreateAdminFurnitureColorQualities < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_color_qualities do |t|
      t.string :name
      t.text :comment

      t.timestamps
    end
  end
end
