class AddImagesToFurnitureType < ActiveRecord::Migration[5.0]
  def change
    add_column :furniture_types, :images, :json
  end
end
