FactoryGirl.define do
  factory :admin_furniture_furniture, class: 'Admin::Furniture::Furniture' do
    association :type, factory: :admin_furniture_type
    name { generate :string }
  end
end
