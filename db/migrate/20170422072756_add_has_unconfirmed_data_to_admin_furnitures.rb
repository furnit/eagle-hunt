class AddHasUnconfirmedDataToAdminFurnitures < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_furnitures, :has_unconfirmed_data, :boolean, default: false
  end
end
