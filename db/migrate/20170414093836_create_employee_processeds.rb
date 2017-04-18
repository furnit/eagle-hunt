class CreateEmployeeProcesseds < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_processeds do |t|
      t.references :admin_furniture, foreign_key: true
      t.references :user, foreign_key: true
      t.string     :as_symbol
      t.index      :as_symbol
      t.index 	   [:admin_furniture_id, :user_id, :as_symbol], unique: true, name: :index_unique_employee_processeds_all
      t.timestamps
    end
  end
end
