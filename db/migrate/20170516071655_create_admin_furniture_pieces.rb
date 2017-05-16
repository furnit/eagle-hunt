class CreateAdminFurniturePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_furniture_pieces do |t|
      t.integer :piece
      t.text :comment

      t.timestamps
    end
  end
end
