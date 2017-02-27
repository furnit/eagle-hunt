class CreateAvailWorkshops < ActiveRecord::Migration[5.0]
  def change
    create_table :avail_workshops do |t|
      t.references :furniture, foreign_key: true
      t.references :workshop, foreign_key: true
      t.float :proposed_cost

      t.timestamps
    end
  end
end
