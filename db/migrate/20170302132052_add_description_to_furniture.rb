class AddDescriptionToFurniture < ActiveRecord::Migration[5.0]
  def change
    add_column :furnitures, :description, :text
    change_column :furnitures, :comment, :string, :limit => 140
  end
end
