class CreateEmployeeNagashes < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_nagashes do |t|
      t.references  :furniture
      t.references  :user
      t.float       :wage
      t.float       :astare_avaliye
      t.float       :astare_asli
      t.float       :range_asli
      t.float       :rouye

      t.timestamps
    end
  end
end
