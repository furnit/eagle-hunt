class CreateAdminSellingConfigProfits < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_selling_config_profits do |t|
      t.float :overall
      t.boolean :overall_fixed
      t.float :marketer
      t.boolean :marketer_fixed
      t.float :marketed
      t.boolean :marketed_fixed

      t.timestamps
    end
  end
end
