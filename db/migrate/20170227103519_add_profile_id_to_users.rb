class AddProfileIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :profile, foreign_key: { on_delete: :cascade, on_update: :cascade }
  end
end
