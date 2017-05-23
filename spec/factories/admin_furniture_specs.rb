FactoryGirl.define do
  factory :admin_furniture_spec, class: 'Admin::Furniture::Spec' do
    unit { generate :string }
    name { generate :string }
    comment { generate :text }
  end
end
