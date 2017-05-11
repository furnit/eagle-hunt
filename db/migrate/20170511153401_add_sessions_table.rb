class AddSessionsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string :session_id, :null => false
      t.text :data
      t.timestamp :verified_at
      t.string    :verification_token
      t.timestamp :verification_send_at
      t.timestamp :last_accessed_at

      t.timestamps
    end

    add_index :sessions, :session_id, :unique => true
    add_index :sessions, :updated_at
  end
end
