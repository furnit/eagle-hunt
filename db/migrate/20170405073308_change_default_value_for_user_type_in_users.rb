class ChangeDefaultValueForUserTypeInUsers < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :users, :admin_user_type_id, 2
  end
end
