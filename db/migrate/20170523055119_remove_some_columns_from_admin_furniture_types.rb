class RemoveSomeColumnsFromAdminFurnitureTypes < ActiveRecord::Migration[5.0]
  def change
    change_table :admin_furniture_types, bulk: true do |t|
      t.remove :is_inside_type
      t.remove :is_outside_type
    end
  end
end
