class CreateAdminPricingWoods < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_pricing_woods do |t|
      t.references :admin_furniture_wood_type, foreign_key: true
      t.integer :price
      t.text :comment

      t.timestamps
    end
  end
end
