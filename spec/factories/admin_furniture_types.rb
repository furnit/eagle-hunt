FactoryGirl.define do
  factory :admin_furniture_type, class: 'Admin::Furniture::Type' do
    name { generate :string }
    comment { generate :text }
  end
end
