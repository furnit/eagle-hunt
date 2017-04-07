class AddTypeInsiderAndTypeOutsiderToFurnitureTypes < ActiveRecord::Migration[5.0]
  def change
  	change_table :furniture_types, :bulk => true do |t|
    	t.boolean :is_inside_type, default: false
    	t.boolean :is_outside_type, default: false
    end
  end
end
