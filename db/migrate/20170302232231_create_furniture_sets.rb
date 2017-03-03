class CreateFurnitureSets < ActiveRecord::Migration[5.0]
  def change
    create_table :furniture_sets do |t|
      t.references :furniture, foreign_key: true
      t.references :sitting_set, foreign_key: true

      t.timestamps
    end
  end
end
