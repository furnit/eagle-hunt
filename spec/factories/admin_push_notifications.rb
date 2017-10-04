FactoryGirl.define do
  factory :admin_push_notification, class: 'Admin::PushNotification' do
    type ""
    message "MyText"
    sent_at "2017-10-04 14:04:26"
  end
end
