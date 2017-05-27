FactoryGirl.define do
  factory :admin_furniture_paint_color_quality, class: 'Admin::Furniture::Paint::ColorQuality' do
    name { generate :string }
    comment { generate :text }
  end
end
