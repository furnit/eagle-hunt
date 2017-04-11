class CreateAdminFurnitureSpecs < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_specs do |t|
      t.string :name
      t.string :comment
      t.string :scale

      t.timestamps
    end
  end
end
