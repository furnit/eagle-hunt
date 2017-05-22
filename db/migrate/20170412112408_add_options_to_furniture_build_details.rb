class AddOptionsToFurnitureBuildDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_furniture_build_details, :options, :json
  end
end
