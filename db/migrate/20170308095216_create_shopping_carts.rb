class CreateShoppingCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_carts do |t|
      t.references :user, foreign_key: true
      t.references :furniture, foreign_key: true

      t.timestamps
    end
	add_index :shopping_carts, [:user_id, :furniture_id], unique: true
  end
end
