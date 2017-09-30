class CreateAdminFabrics < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_fabrics do |t|
      t.references :admin_fabric_quality, foreign_key: true, index: { name: 'index_fabric_type' }
      t.references :admin_fabric_brand, foreign_key: true, index: { name: 'index_fabric_brand' }
      t.text :comment
      t.json :images
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
