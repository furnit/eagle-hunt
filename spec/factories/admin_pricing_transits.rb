FactoryGirl.define do
  factory :admin_pricing_transit, class: 'Admin::Pricing::Transit' do
    association :workshop, factory: :admin_workshop_workshop
    association :state, factory: :state
    price { 1e+6 * rand }
  end
end
