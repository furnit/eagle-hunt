class CreateAdminFurnitureSets < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_sets do |t|
      t.string :name
      t.json :config
      t.text :comment

      t.timestamps
    end
  end
end
