class AddTempPasswordTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :temp_password_token, :string
    add_column :users, :temp_password_token_sent_at, :timestamp
  end
end
