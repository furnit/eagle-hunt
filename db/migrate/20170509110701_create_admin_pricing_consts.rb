class CreateAdminPricingConsts < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_pricing_consts do |t|
      t.integer :guni
      t.integer :chasb
      t.integer :payemobl
      t.integer :sage
      t.integer :mikh
      t.integer :extra

      t.timestamps
    end
  end
end
