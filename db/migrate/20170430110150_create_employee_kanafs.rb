class CreateEmployeeKanafs < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_kanafs do |t|
      t.references :furniture
      t.references :user
      t.float :wage
      t.float :choob
      t.integer :days_to_complete
      t.integer :confirmed, limit: 1

      t.timestamps
    end
  end
end
