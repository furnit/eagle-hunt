class AddReadyForPricingToAdminFurnitureFurnitures < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_furniture_furnitures, :ready_for_pricing, :boolean
  end
end
