class CreateFabricColors < ActiveRecord::Migration[5.0]
  def change
    create_table :fabric_colors do |t|
      t.references :fabric, foreign_key: true
      t.string :name
      t.text :comment
      t.json :images

      t.timestamps
    end
  end
end
