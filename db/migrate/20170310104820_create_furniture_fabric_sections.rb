class CreateFurnitureFabricSections < ActiveRecord::Migration[5.0]
  def change
    create_table :furniture_fabric_sections do |t|
      t.string :name
      t.string :comment

      t.timestamps
    end
  end
end
