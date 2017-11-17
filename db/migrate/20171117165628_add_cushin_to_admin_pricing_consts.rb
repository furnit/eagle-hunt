class AddCushinToAdminPricingConsts < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_pricing_consts, :cushin, :integer, default: 0
  end
end
