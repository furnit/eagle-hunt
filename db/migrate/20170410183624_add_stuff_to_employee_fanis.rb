class AddStuffToEmployeeFanis < ActiveRecord::Migration[5.0]
  def change
  	change_table :employee_fanis, bulk: true do |t|
  		t.boolean :needs_kande, default: false
  		t.boolean :needs_kanaf, default: false
    	t.boolean :needs_rang, default: false
    	t.integer :days_to_complete, default: 0
    end
  end
end
