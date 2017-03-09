class CreateFurnitureCosts < ActiveRecord::Migration[5.0]
  def change
    create_table :furniture_costs do |t|
      t.references :furniture, foreign_key: true
      t.float :rokob_sage
      t.float :rokob_garni
      t.float :rokob_abr
      t.float :dast_mozd
      t.float :khayat_parche
      t.float :khayat_kosan_parche
      t.float :khayat_kosan_abr
      t.float :khayat_poshti_parche
      t.float :khayat_poshti_abr
      t.float :khayat_ziri_parche
      t.float :khayat_ziri_abr

      t.timestamps
    end
  end
end
