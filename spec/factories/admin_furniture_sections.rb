FactoryGirl.define do
  factory :admin_furniture_section, class: 'Admin::Furniture::Section' do
    tag { generate :string }
    name { generate :string }
    comment { generate :text }
  end
end
