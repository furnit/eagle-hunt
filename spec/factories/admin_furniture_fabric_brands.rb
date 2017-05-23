FactoryGirl.define do
  factory :admin_furniture_fabric_brand, class: 'Admin::Furniture::Fabric::Brand' do
    name { generate :string }
    comment { generate :text }
  end
end
