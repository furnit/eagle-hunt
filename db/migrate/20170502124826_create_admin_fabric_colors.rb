class CreateAdminFabricColors < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_fabric_colors do |t|
      t.string :name
      t.string :value, null: false
      t.text :comment

      t.index :value, unique: true

      t.timestamps
    end
  end
end
