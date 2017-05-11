class CreateAdminContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_contacts do |t|
      t.string :name
      t.text :phone_numbers
      t.text :address
      t.text :comment

      t.timestamps
    end
  end
end
