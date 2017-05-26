FactoryGirl.define do
  factory :admin_furniture_fabric_color, class: 'Admin::Furniture::Fabric::Color' do
    name { generate :string }
    comment { generate :text }
    value { generate :hex_color }
    model { {k: 0, init: [], runs: 0} }
  end
end
