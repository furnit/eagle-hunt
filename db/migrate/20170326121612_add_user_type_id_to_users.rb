class AddUserTypeIdToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :auth_level
    add_reference :users, :admin_user_type, foreign_key: true
  end
end
