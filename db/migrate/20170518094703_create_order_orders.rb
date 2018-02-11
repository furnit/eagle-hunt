class CreateOrderOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :order_orders do |t|
      t.references :user, foreign_key: true, null: false
      t.references :admin_furniture_furniture, foreign_key: true, null: false
      t.json       :order_details
      t.boolean    :is_default, default: false
      t.references :default, references: :admin_uploaded_file, null: true
      t.boolean    :verified, default: false

      t.timestamps
    end
  end
end
