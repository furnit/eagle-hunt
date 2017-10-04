class CreateAdminPushNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_push_notifications do |t|
      t.text :message
      t.string :category
      t.datetime :sent_at

      t.timestamps
    end
  end
end
