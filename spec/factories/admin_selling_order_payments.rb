FactoryGirl.define do
  factory :admin_selling_order_payment, class: 'Admin::Selling::Order::Payment' do
    order_order nil
    amount 1.5
    trans_id "MyString"
    status "MyString"
  end
end
