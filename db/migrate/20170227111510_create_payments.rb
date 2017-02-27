class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :accounting, foreign_key: true
      t.float :payment

      t.timestamps
    end
  end
end
