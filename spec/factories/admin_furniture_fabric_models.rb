FactoryGirl.define do
  factory :admin_furniture_fabric_model, class: 'Admin::Furniture::Fabric::Model' do
    association :fabric, factory: :admin_furniture_fabric_fabric
    name { generate :string }
  end
end
