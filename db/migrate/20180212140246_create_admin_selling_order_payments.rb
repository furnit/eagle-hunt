class CreateAdminSellingOrderPayments < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_selling_order_payments do |t|
      t.references :order_order, foreign_key: true
      t.float :amount
      t.string :trans_id
      t.string :status

      t.timestamps
    end
  end
end
