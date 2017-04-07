class AddPostalCodeToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :postal_code, :string
  end
end
