class RenameFabricalTables < ActiveRecord::Migration[5.0]
  def change
    [
      :admin_fabric_brands, :admin_fabric_color_indices,
      :admin_fabric_colors, :admin_fabric_types, :admin_fabrics
    ].each do |t|
      rename_table t, t.to_s.gsub('admin_fabric', 'admin_furniture_fabric')
    end
    change_table :admin_furniture_fabric_color_indices, balk: true do |t|
      t.rename :admin_fabric_id, :admin_furniture_fabric_id
      t.rename :admin_fabric_image, :admin_furniture_fabric_image
      t.rename :admin_fabric_color_id, :admin_furniture_fabric_color_id
    end
    change_table :admin_furniture_fabrics, balk: true do |t|
      t.rename :admin_fabric_type_id, :admin_furniture_fabric_type_id
      t.rename :admin_fabric_brand_id, :admin_furniture_fabric_brand_id
    end
  end
end
