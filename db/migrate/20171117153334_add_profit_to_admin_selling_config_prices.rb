class AddProfitToAdminSellingConfigPrices < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_selling_config_prices, :profit, :float, default: 0
  end
end
