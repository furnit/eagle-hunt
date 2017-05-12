class CreateAdminPricingTransits < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_pricing_transits do |t|
      t.references :admin_workshop_workshop, foreign_key: true
      t.references :state, foreign_key: true
      t.integer :price, limit: 8

      t.timestamps
    end
  end
end
