class DropTableAdminSellingPaymentPayments < ActiveRecord::Migration[5.0]
  def change
    drop_table :admin_selling_payment_payments
  end
end
