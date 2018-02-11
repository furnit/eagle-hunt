FactoryGirl.define do
  factory :admin_selling_payment_payment, class: 'Admin::Selling::Payment::Payment' do
    order_order nil
    amount 1.5
    trans_id "MyString"
    status "MyString"
  end
end
