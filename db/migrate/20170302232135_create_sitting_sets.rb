class CreateSittingSets < ActiveRecord::Migration[5.0]
  def change
    create_table :sitting_sets do |t|
      t.integer :count
      t.json :details
      t.text :comment

      t.timestamps
    end
  end
end
