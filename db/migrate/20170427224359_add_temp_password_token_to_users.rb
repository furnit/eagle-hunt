class AddTempPasswordTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :temp_password_token
      t.timestamp :temp_password_token_sent_at
      t.timestamp :temp_password_token_confirmed_at
    end
  end
end
