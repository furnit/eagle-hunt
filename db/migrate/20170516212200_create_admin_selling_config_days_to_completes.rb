class CreateAdminSellingConfigDaysToCompletes < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_selling_config_days_to_completes do |t|
      t.integer :extra

      t.timestamps
    end
  end
end
