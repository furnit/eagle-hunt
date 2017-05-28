FactoryGirl.define do
  factory :admin_pricing_wood, class: 'Admin::Pricing::Wood' do
    association :type, factory: :admin_furniture_wood_type
    price { 1e+5 * rand }
  end
end
