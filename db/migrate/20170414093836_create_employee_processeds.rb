class CreateEmployeeProcesseds < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_processeds do |t|
      t.references :admin_furniture, foreign_key: true
      t.references :user, foreign_key: true
      t.index 	   [:admin_furniture_id, :user_id], unique: true, name: :index_admin_furniture_id_user_id
      t.timestamps
    end
  end
end
