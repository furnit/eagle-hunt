class CreateAdminSms < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_sms do |t|
      t.text    :message
      t.text    :to
      t.boolean :is_urgent, default: false

      t.timestamps
    end
  end
end
