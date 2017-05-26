FactoryGirl.define do
  factory :admin_furniture_wood_type, class: 'Admin::Furniture::Wood::Type' do
    name { generate :string }
    comment { generate :text }
  end
end
