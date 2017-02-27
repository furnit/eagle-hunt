class CreateAccountings < ActiveRecord::Migration[5.0]
  def change
    create_table :accountings do |t|
      t.references :order, foreign_key: true
      t.float :total_payment

      t.timestamps
    end
  end
end
