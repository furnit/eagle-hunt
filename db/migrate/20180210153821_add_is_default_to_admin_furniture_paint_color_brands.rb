class AddIsDefaultToAdminFurniturePaintColorBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_furniture_paint_color_brands, :is_default, :boolean, default: false
    add_index :admin_furniture_paint_color_brands, :is_default
  end
end
