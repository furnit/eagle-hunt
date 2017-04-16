class CreateNotifyClientOnFurnitureAvailables < ActiveRecord::Migration[5.0]
  def change
    create_table :notify_client_on_furniture_availables do |t|
      t.references :admin_furniture, foreign_key: {on_delete: :cascade, on_update: :cascade}, index:{name: :index_notify_admin_furniture}
      t.string :phone_number
      t.integer :status, limit: 1, default: 0

      t.timestamps
    end
  end
end
