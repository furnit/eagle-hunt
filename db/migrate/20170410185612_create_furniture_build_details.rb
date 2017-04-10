class CreateFurnitureBuildDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :furniture_build_details do |t|
      t.references :admin_furniture_sections, foreign_key: true
      t.references :admin_furniture_specs, foreign_key: true
      t.float :value

      t.timestamps
    end
  end
end
