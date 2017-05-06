class RenameFurnitureColor < ActiveRecord::Migration[5.0]
  def change
    ["s", "_qualities", "_brands"].each do |postfix|
      rename_table "admin_furniture_color#{postfix}", "admin_furniture_paint_color#{postfix}"
    end
    change_table :admin_furniture_paint_colors, balk: true do |t|
      t.rename :admin_furniture_color_qualities_id, :admin_furniture_paint_color_qualities_id
      t.rename :admin_furniture_color_brands_id, :admin_furniture_paint_color_brands_id
    end
  end
end
