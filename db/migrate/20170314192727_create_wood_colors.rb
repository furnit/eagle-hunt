class CreateWoodColors < ActiveRecord::Migration[5.0]
  def change
    create_table :wood_colors do |t|
      t.references :wood, foreign_key: true
      t.string :name
      t.text :comment
      t.json :images

      t.timestamps
    end
  end
end
