class AddStateToProfile < ActiveRecord::Migration[5.0]
  def change
    add_reference :profiles, :state, foreign_key: true
  end
end
