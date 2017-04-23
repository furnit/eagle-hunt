class AddDataLockedAtToFurnitures < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_furnitures, :data_locked_at, :timestamp
  end
end
