class CreateOrderOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :order_orders do |t|
      t.references :user, foreign_key: true
      t.references :admin_furniture_furniture, foreign_key: true
      t.reference :admin_furniture_fabric_fabric
      t.references :fabric, foreign_key: true
      t.references :admin_furniture_paint_color, foreign_key: true
      t.references :admin_furniture_wood_types, foreign_key: true

      t.timestamps
    end
  end
end
