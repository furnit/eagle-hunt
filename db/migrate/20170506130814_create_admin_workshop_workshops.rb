class CreateAdminWorkshopWorkshops < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_workshop_workshops do |t|
      t.string :name
      t.references :state, foreign_key: true
      t.text :address
      t.references :user, foreign_key: true
      t.string :phone_number
      t.text :comment

      t.timestamps
    end
  end
end
