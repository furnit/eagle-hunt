class CreateCostFactors < ActiveRecord::Migration[5.0]
  def change
    create_table :cost_factors do |t|

      t.float :size_parche
      t.float :size_kanaf
      t.float :size_abr

      t.float :wage_khayat
      t.float :wage_rokob
      t.float :wage_naghash
      t.float :wage_najar
      t.float :wage_extra

      t.float :parche_colour
      t.float :parche_design
      t.float :kande_colours
      t.float :kande_design

      t.float :transfer_cost

      t.float :extras

      t.float :profit_percentage

      t.timestamps
    end
  end
end
