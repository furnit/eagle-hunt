class CreateFurnitures < ActiveRecord::Migration[5.0]
  def change
    create_table :furnitures do |t|
      t.string :name
      t.float :size_parche
      t.float :size_kalaf
      t.float :size_abr

      t.float :wage_khayat
      t.float :wage_rokob
      t.float :wage_naghash
      t.float :wage_najar
      t.float :wage_extra

      t.integer :transfer_counts

      t.json :images

      t.boolean :available, default: false
      t.text :comment

      t.timestamps
    end
  end
end
