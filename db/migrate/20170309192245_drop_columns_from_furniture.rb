class DropColumnsFromFurniture < ActiveRecord::Migration[5.0]
  def change
  	change_table :furnitures, :bulk => true do |t|
  		t.remove :size_parche
		t.remove :size_kalaf
		t.remove :size_abr
		t.remove :wage_khayat
		t.remove :wage_rokob
		t.remove :wage_naghash
		t.remove :wage_najar
		t.remove :wage_extra
		t.remove :transfer_counts
  	end
  end
end
