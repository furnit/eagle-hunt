FactoryGirl.define do
  factory :admin_push_notification, class: 'Admin::PushNotification' do
    message { generate :text }
    category { generate :string }
  end
end
