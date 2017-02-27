class CreateWorkshopTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :workshop_types do |t|
      t.string :type
      t.text :comment

      t.timestamps
    end
  end
end
