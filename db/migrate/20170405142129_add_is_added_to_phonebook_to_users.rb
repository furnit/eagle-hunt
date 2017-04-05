class AddIsAddedToPhonebookToUsers < ActiveRecord::Migration[5.0]
  def change
  	change_table :users, bulk: true do |t|
    	t.boolean :is_added_to_phonebook, default: false
    	t.boolean :error_on_add_to_phonebook, default: false
  	end
  end
end
