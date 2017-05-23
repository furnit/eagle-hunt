FactoryGirl.define do
  factory :admin_furniture_build_detail, class: 'Admin::Furniture::BuildDetail' do
    association :spec, factory: :admin_furniture_spec
    association :section, factory: :admin_furniture_section
    value { rand * 100 }
  end
end
