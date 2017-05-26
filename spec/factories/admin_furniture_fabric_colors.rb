FactoryGirl.define do
  factory :admin_furniture_fabric_color, class: 'Admin::Furniture::Fabric::Color' do
    value "#e7e7e7"
    name { generate :string }
    comment { generate :text }
    model { {k: 0, init: [], runs: 0} }
  end
end
