class CreateFurnitures < ActiveRecord::Migration[5.0]
  def change
    create_table :furnitures do |t|
      t.string :name
      t.references :furniture_detail, foreign_key: true
      t.references :furniture_wage, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
