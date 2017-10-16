FactoryGirl.define do
  factory :admin_furniture_wood_color, class: 'Admin::Furniture::Wood::Color' do
    name { generate :string }
    value { "abcdef" }
    comment { generate :text }
  end
end
