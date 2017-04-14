class UniquenessToEmployeeProcessed < ActiveRecord::Migration[5.0]
  def change
  	add_index :employee_processeds, [:admin_furniture_id, :user_id], unique: true
  end
end
