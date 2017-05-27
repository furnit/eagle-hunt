FactoryGirl.define do
  factory :admin_furniture_paint_color_brand, class: 'Admin::Furniture::Paint::ColorBrand' do
    name { generate :string }
    comment { generate :text }
  end
end
