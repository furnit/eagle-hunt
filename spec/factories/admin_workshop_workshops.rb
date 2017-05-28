FactoryGirl.define do
  factory :admin_workshop_workshop, class: 'Admin::Workshop::Workshop' do
    association :state, factory: :state
    association :manager, factory: :user
    name { generate :string }
    address { generate :text }
    phone_number { generate :phone_number }
    comment { generate :text }
  end
end
