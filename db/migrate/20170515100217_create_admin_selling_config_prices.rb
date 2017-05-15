class CreateAdminSellingConfigPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_selling_config_prices do |t|
      t.references :admin_furniture_furniture, foreign_key: true, index: { name: "index_config_price_furniture" }
      t.references :admin_furniture_fabric_brand, foreign_key: true, index: { name: "index_config_price_fabric" }
      t.references :admin_furniture_paint_color_brand, foreign_key: true, index: { name: "index_config_price_paint_color" }
      t.references :admin_furniture_wood_type, foreign_key: true, index: { name: "index_config_price_wood" }
      t.float :overall_cost

      t.timestamps
    end
  end
end
