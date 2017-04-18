class AddConfirmedToEmployeeNagashes < ActiveRecord::Migration[5.0]
  def change
    add_column :employee_nagashes, :confirmed, :integer, limit: 1, default: 0
  end
end
