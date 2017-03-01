class AddFurnitureTypeToFurniture < ActiveRecord::Migration[5.0]
  def change
    add_reference :furnitures, :furniture_type, foreign_key: true
  end
end
