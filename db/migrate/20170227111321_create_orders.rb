class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :furniture, foreign_key: true
      t.references :parche_colour, foreign_key: true
      t.references :parche_design, foreign_key: true
      t.references :kande_colour, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
