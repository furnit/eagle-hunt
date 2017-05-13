class CreateAdminPricingKanafs < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_pricing_kanafs do |t|
      t.integer :price
      t.text :comment

      t.timestamps
    end
  end
end
