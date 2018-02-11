class ChangeTableOrderOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :order_orders, :address, :text, null: false
    add_reference :order_orders, :state, foreign_key: true, null: false
  end
end
