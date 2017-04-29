class AddTempPasswordTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :two_step_auth_token
      t.timestamp :two_step_auth_token_sent_at
      t.timestamp :two_step_auth_token_confirmed_at
    end
  end
end
