class RenameTableNotifyClientOnFurntiureAvailable < ActiveRecord::Migration[5.0]
  def change
    rename_table :notify_client_on_furniture_availables, :notify_on_furniture_availables
  end
end
