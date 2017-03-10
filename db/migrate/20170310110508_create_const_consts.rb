class CreateConstConsts < ActiveRecord::Migration[5.0]
  def change
    create_table :const_consts do |t|
      t.float :guni
      t.float :chasb
      t.float :sage
      t.float :mixkub
      t.float :extra

      t.timestamps
    end
  end
end
