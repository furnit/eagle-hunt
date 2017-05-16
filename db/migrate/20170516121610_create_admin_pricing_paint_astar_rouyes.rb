class CreateAdminPricingPaintAstarRouyes < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_pricing_paint_astar_rouyes do |t|
      t.float :astare_avaliye
      t.float :astare_asli
      t.float :rouye
      t.float :batune

      t.timestamps
    end
  end
end
