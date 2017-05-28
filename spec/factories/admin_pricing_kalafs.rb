FactoryGirl.define do
  factory :admin_pricing_kalaf, class: 'Admin::Pricing::Kalaf' do
    price { 1e+5 * rand }
  end
end
