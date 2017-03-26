class CreateAdminUserTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_user_types do |t|
      t.string :name
      t.text :comment
      t.integer :auth_level

      t.timestamps
    end
  end
end
