class CreateTransferCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :transfer_costs do |t|
      t.text :title
      t.float :cost
      t.text :comment

      t.timestamps
    end
  end
end
