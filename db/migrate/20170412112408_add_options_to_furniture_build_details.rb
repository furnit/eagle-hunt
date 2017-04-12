class AddOptionsToFurnitureBuildDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :furniture_build_details, :options, :json
  end
end
