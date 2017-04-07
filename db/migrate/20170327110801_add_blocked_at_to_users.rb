class AddBlockedAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :blocked_at, :datetime
  end
end
