FactoryGirl.define do
  factory :admin_furniture_wood_color_weight, class: 'Admin::Furniture::Wood::ColorWeight' do
    name { generate :string }
    comment { generate :text }
  end
end
