class CreateEmployeeFanis < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_fanis do |t|

      t.timestamps
    end
  end
end
