FactoryGirl.define do
  factory :admin_furniture_fabric_cushion, class: 'Admin::Furniture::Fabric::Cushion' do
    label { generate :string }
    width { 100 * rand }
    height { 100 * rand }
    comment { generate :text }
  end
end
