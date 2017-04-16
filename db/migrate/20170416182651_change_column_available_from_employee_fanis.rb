class ChangeColumnAvailableFromEmployeeFanis < ActiveRecord::Migration[5.0]
  def up
    change_column :employee_fanis, :confirmed, :tinyint, limit: 1, default: 0
  end
  def down
    change_column :employee_fanis, :confirmed, :boolean
  end
end
