class AddDeletedAtToFurniture < ActiveRecord::Migration[5.0]
  def change
    add_column :furnitures, :deleted_at, :datetime
    add_index :furnitures, :deleted_at
  end
end
