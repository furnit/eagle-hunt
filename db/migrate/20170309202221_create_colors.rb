class CreateColors < ActiveRecord::Migration[5.0]
  def change
    create_table :colors do |t|
      t.string :name
      t.text :comment
      t.float :cost

      t.timestamps
    end
  end
end
