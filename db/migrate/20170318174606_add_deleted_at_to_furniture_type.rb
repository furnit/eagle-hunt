class AddDeletedAtToFurnitureType < ActiveRecord::Migration[5.0]
  def change
    add_column :furniture_types, :deleted_at, :datetime
    add_index :furniture_types, :deleted_at
  end
end
