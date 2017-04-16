class CreateEmployeeFanisFurnitureBuildDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_fanis_furniture_build_details do |t|
      t.references :employee_fani, foreign_key: {on_delete: :cascade, on_update: :cascade}, index: { name: :index_employee_fani }
      t.references :furniture_build_detail, foreign_key: {on_delete: :cascade, on_update: :cascade}, index: { name: :index_furniture_build_detail }

      t.timestamps
    end
  end
end
