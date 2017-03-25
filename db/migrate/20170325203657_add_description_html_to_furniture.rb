class AddDescriptionHtmlToFurniture < ActiveRecord::Migration[5.0]
  def change
    add_column :furnitures, :description_html, :string
  end
end
