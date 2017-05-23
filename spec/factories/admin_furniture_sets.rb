FactoryGirl.define do
  factory :admin_furniture_set, class: 'Admin::Furniture::Set' do
    name { generate :string }
    comment { generate :text }
  end
end
