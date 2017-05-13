class CreateAdminPricingPaintColors < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_pricing_paint_colors do |t|
      t.references :admin_furniture_paint_color_brand, foreign_key: true, index: { name: "index_pricing_paint_color_brand" }
      t.integer :price
      t.text :comment

      t.timestamps
    end
  end
end
