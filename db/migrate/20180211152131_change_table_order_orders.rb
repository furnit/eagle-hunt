class ChangeTableOrderOrders < ActiveRecord::Migration[5.0]
  def change
    change_table :order_orders, bulk: true do |t|
      t.references :state, foreign_key: true, null: false
      t.text       :address, null: false
    end
  end
end
