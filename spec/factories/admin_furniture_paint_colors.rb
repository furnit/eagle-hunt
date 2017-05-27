FactoryGirl.define do
  factory :admin_furniture_paint_color, class: 'Admin::Furniture::Paint::Color' do
    association :brand, factory: :admin_furniture_paint_color_brand
    association :quality, factory: :admin_furniture_paint_color_quality
    name { generate :string }
    comment { generate :text }
    color_value { generate :hex_color }
  end
end
