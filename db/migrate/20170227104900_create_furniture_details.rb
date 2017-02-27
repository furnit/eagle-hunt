class CreateFurnitureDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :furniture_details do |t|
      t.float :size_parche
      t.float :size_kanaf
      t.float :size_abr
      t.boolean :available
      t.json :images

      t.timestamps
    end
  end
end
