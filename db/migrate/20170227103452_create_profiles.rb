class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: { on_delete: :cascade, on_update: :cascade }
      t.string :first_name
      t.string :last_name
      t.text :address
      t.json :avatar

      t.timestamps
    end
    add_index :profiles, :user_id, unique: true, name: "index_unique_user_id"
  end
end
