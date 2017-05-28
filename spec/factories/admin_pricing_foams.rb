FactoryGirl.define do
  factory :admin_pricing_foam, class: 'Admin::Pricing::Foam' do
    association :type, factory: :admin_furniture_foam_type
    price { 1e+5 * rand }
  end
end
