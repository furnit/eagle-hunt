class AddImageProfileToFurniture < ActiveRecord::Migration[5.0]
  def change
    add_column :furnitures, :image_profile_id, :integer
    add_column :furnitures, :image_profile, :json
  end
end
