class CreateWoods < ActiveRecord::Migration[5.0]
  def change
    create_table :woods do |t|
      t.string :name
      t.text :comment
      t.float :cost

      t.timestamps
    end
  end
end
