class AddCeasedAtToAdminWorkshopWorkshops < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_workshop_workshops, :ceased_at, :timestamp
  end
end
