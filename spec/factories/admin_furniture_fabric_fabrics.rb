FactoryGirl.define do
  factory :admin_furniture_fabric_fabric, class: 'Admin::Furniture::Fabric::Fabric' do
    association :brand, factory: :admin_furniture_fabric_brand
    association :quality, factory: :admin_furniture_fabric_quality
  end
end
