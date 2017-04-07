class AddCreatorUserIdAndChangePasswordToUsers < ActiveRecord::Migration[5.0]
  def change
  	change_table :users, :bulk => true do |t|
	    t.integer :creator_user_id
	    t.index   :creator_user_id
	    t.boolean :change_password, default: false
	end
  end
end
