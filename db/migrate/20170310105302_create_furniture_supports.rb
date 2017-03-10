class CreateFurnitureSupports < ActiveRecord::Migration[5.0]
  def change
    create_table :furniture_supports do |t|
      t.string :name
      t.float :cost
      t.string :comment

      t.timestamps
    end
  end
end
