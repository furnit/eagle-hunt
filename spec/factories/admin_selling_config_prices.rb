FactoryGirl.define do
  factory :admin_selling_config_price, class: 'Admin::Selling::Config::Price' do
    association :wood, factory: :admin_furniture_wood_type
    association :fabric_brand, factory: :admin_furniture_fabric_brand
    association :furniture, factory: :admin_furniture_furniture
    association :paint_color, factory: :admin_furniture_paint_color_brand
    association :set, factory: :admin_furniture_set

    overall_cost { 1e+7 * rand }
  end
end
