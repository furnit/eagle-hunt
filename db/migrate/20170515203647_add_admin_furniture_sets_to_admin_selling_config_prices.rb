class AddAdminFurnitureSetsToAdminSellingConfigPrices < ActiveRecord::Migration[5.0]
  def change
    add_reference :admin_selling_config_prices, :admin_furniture_set, foreign_key: true
  end
end
