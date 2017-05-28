FactoryGirl.define do
  factory :admin_pricing_fabric, class: 'Admin::Pricing::Fabric' do
    association :brand, factory: :admin_furniture_fabric_brand
    price { 1e+5 * rand }
  end
end
