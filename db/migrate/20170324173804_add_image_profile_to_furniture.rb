class AddImageProfileToFurniture < ActiveRecord::Migration[5.0]
  def change
    add_column :furnitures, :cover_details, :json
  end
end
