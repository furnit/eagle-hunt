class CreateFurnitureBuildDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :furniture_build_details do |t|
      t.references :admin_furniture_section, foreign_key: true
      t.references :admin_furniture_spec, foreign_key: true
      t.float :value

      t.timestamps
    end
  end
end
