class CreateEmployeeOveralls < ActiveRecord::Migration[5.0]
  [:Fani, :Nagash, :Najar, :Kalaf].each do |t|
    eval("class ::Employee::#{t.to_s} < ActiveRecord::Base
          end")
  end
  def change
    columns = [];
    general_exclude_columns = [:id, :furniture_id, :user_id, :created_at, :updated_at, :confirmed]
    [
      {
        class: '::Employee::Fani',
        exclude: [],
        additions: [
          {type: :json, name: "fani_build_details"}
        ]
      },
      {
        class: '::Employee::Nagash',
        exclude: [],
        additions: []
      },
      {
        class: '::Employee::Najar',
        exclude: [],
        additions: []
      },
      {
        class: '::Employee::Kalaf',
        exclude: [],
        additions: []
      }
    ].each do |subt|
      eval(subt[:class]).columns_hash.each do |name, prop|
        next if (general_exclude_columns + subt[:exclude]).include? name.to_sym
        columns << {
          type: prop.type.to_s,
          name: subt[:class].split('::').last.downcase + "_#{name}"
        }
        columns += subt[:additions]
      end
    end

    create_table :employee_overalls do |t|
      t.references :admin_furniture_furniture, foreign_key: true
      
      columns.each do |c|
        eval("t.#{c[:type]} :#{c[:name]}")
      end

      t.timestamps
    end
  end
end
