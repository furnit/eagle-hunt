class CreateAdminFurnitureFabricModels < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_fabric_models do |t|
      t.references :admin_furniture_fabric_fabric, foreign_key: true, index: { name: "index_fabric_model_fabric" }
      t.string :name
      t.json :images

      t.timestamps
    end
  end
end
