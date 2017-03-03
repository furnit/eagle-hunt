class AddCheckLamseAndCountKosanAndCountPoshtiToFurniture < ActiveRecord::Migration[5.0]
  def change
    add_column :furnitures, :check_lamse, :boolean, :default => false
    add_column :furnitures, :count_kosan, :integer, :default => 0
    add_column :furnitures, :count_poshti, :integer, :default => 0
  end
end
