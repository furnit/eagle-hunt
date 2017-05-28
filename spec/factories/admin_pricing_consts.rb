FactoryGirl.define do
  factory :admin_pricing_const, class: 'Admin::Pricing::Const' do
    guni { 1e+4 * rand }
    chasb { 1e+4 * rand }
    payemobl { 1e+4 * rand }
    sage { 1e+4 * rand }
    mikh { 1e+4 * rand }
    extra { 3e+5 * rand }
  end
end
