class CreateAdminPricingFabrics < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_pricing_fabrics do |t|
      t.references :admin_furniture_fabric_brand, foreign_key: true
      t.integer :price
      t.text :comment

      t.timestamps
    end
  end
end
