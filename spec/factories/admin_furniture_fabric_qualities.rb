FactoryGirl.define do
  factory :admin_furniture_fabric_quality, class: 'Admin::Furniture::Fabric::Quality' do
    name { generate :string }
    comment { generate :text }
  end
end
