class CreatePageItems < ActiveRecord::Migration[5.0]
  def change
    create_table :page_items do |t|
      t.string :controller
      t.string :action
      t.json :details

      t.timestamps
    end
  end
end
