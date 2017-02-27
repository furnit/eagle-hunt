class CreateFurnitureWages < ActiveRecord::Migration[5.0]
  def change
    create_table :furniture_wages do |t|
      t.float :khayat
      t.float :rokob
      t.float :naghash
      t.float :naja
      t.float :extra
      t.text :comment

      t.timestamps
    end
  end
end
