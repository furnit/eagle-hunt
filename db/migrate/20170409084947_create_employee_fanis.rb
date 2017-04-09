class CreateEmployeeFanis < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_fanis do |t|
      t.references :furnitures
      t.references :users
      t.float      :wage_rokob
      t.float      :wage_khayat

      t.boolean    :confirmed, default: false
      t.timestamps
    end
  end
end
