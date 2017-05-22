class CreateAdminFurnitureBuildDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_build_details do |t|
      t.references :admin_furniture_section, foreign_key: true, index: { name: "index_fbd_section" }
      t.references :admin_furniture_spec, foreign_key: true, index: { name: "index_fbd_spec" }
      t.float :value

      t.timestamps
    end
  end
end
