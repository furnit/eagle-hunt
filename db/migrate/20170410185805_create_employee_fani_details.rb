class CreateEmployeeFaniDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_fani_details do |t|
      t.references :employee_fani, foreign_key: true
      t.references :furniture_build_detail, foreign_key: true

      t.timestamps
    end
  end
end
