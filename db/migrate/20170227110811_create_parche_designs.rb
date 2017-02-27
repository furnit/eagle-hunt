class CreateParcheDesigns < ActiveRecord::Migration[5.0]
  def change
    create_table :parche_designs do |t|
      t.json :details
      t.float :cost

      t.timestamps
    end
  end
end
