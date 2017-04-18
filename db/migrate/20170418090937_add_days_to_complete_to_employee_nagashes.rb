class AddDaysToCompleteToEmployeeNagashes < ActiveRecord::Migration[5.0]
  def change
    add_column :employee_nagashes, :days_to_complete, :integer
  end
end
