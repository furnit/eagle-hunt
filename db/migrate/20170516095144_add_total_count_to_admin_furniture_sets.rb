class AddTotalCountToAdminFurnitureSets < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_furniture_sets, :total_count, :integer
  end
end
