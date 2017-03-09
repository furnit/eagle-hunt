class AddCheckLamseAndCountKosanAndCountPoshtiToFurniture < ActiveRecord::Migration[5.0]
  def change
  	change_table :furnitures, :bulk => true do |t|
  		t.integer :count_ziri, default: 0
    	t.integer :count_kosan, :default => 0
    	t.integer :count_poshti, :default => 0
    	t.boolean :check_lamse, :default => false
    end
  end
end
