class CreateWorkshops < ActiveRecord::Migration[5.0]
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :manager
      t.text :address
      t.string :contact
      t.text :comment
      t.references :workshop_type

      t.timestamps
    end
  end
end
