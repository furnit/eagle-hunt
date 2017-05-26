FactoryGirl.define do
  factory :admin_furniture_fabric_model_color, class: 'Admin::Furniture::Fabric::ModelColor' do
    association :model, factory: :admin_furniture_fabric_model
    association :color, factory: :admin_furniture_fabric_color
  end
end
