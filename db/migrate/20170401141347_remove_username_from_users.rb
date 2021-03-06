class RemoveUsernameFromUsers < ActiveRecord::Migration[5.0]
  def change
  	change_table :users, :bulk => true do |t|
  		t.string :phone_number, null: false, default: ''
  		t.index :phone_number, unique: true
  		t.remove :username
  	end
  end
end
