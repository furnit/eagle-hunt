class CreateFurnitureFrameSkeletonCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :furniture_frame_skeleton_costs do |t|
      t.references :furniture, foreign_key: true
      t.references :wood, foreign_key: true
      t.float :amount
      t.float :wage

      t.timestamps
    end
  end
end
