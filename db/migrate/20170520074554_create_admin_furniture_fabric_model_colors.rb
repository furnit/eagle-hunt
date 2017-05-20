class CreateAdminFurnitureFabricModelColors < ActiveRecord::Migration[5.0]
  def change
    # drop_table :admin_furniture_fabric_color_indices
    create_table :admin_furniture_fabric_model_colors do |t|
      t.references :admin_furniture_fabric_model, foreign_key: true, null: false, index: { name: "index_fabric_color_indices_fabric_model" }
      t.references :admin_furniture_fabric_color, foreign_key: true, null: false, index: { name: "index_fabric_color_indices_fabric_color" }

      t.timestamps
    end
  end
end
