class CreateAdminSellingConfigPiecePrices < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_selling_config_piece_prices do |t|
      t.references :admin_furniture_set, foreign_key: true, index: { name: "index_selling_config_piece_prices_set" }
      t.references :admin_furniture_piece, foreign_key: true, index: { name: "index_selling_config_piece_prices_piece" }
      t.float :percentage
      t.text :comment

      t.timestamps
    end
  end
end
