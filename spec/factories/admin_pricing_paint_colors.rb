FactoryGirl.define do
  factory :admin_pricing_paint_color, class: 'Admin::Pricing::PaintColor' do
    association :brand, factory: :admin_furniture_paint_color_brand
    price { 1e+5 * rand }
  end
end
