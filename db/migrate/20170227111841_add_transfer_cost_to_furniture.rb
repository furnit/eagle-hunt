class AddTransferCostToFurniture < ActiveRecord::Migration[5.0]
  def change
    add_reference :furnitures, :transfer_cost, foreign_key: true
  end
end
