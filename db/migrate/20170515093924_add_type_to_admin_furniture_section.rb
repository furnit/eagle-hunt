class AddTypeToAdminFurnitureSection < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_furniture_sections, :tag, :string
  end
end
