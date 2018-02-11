class ChangeTableAdminSellingConfigPrices < ActiveRecord::Migration[5.0]
  def change
    change_table :admin_selling_config_prices, bulk: true do |t|
      t.json   :cost_details
      t.remove :overall_cost
    end
  end
end
