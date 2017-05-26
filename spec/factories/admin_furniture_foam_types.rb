FactoryGirl.define do
  factory :admin_furniture_foam_type, class: 'Admin::Furniture::Foam::Type' do
    name { generate :string }
    comment { generate :text }
  end
end
