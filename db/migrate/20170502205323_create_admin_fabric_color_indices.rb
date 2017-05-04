class CreateAdminFabricColorIndices < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_fabric_color_indices do |t|
      t.references :admin_fabric, foreign_key: true, index: { name: "index_column_admin_fabric" }
      t.integer :admin_fabric_image
      t.references :admin_fabric_color, foreign_key: true, index: { name: "index_column_admin_fabric_color" }

      t.timestamps
    end
  end
end
