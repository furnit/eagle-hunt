class CreateAdminFurnitureStuffAbrs < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_stuff_abrs do |t|
      t.string :name
      t.float :value
      t.string :comment

      t.timestamps
    end
  end
end
