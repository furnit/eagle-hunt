class CreateOrderStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :order_statuses do |t|
      t.json :state
      t.datetime :shipped_at
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
