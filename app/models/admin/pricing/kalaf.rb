class Admin::Pricing::Kalaf < Admin::Pricing::BaseRecord
  after_initialize do
    prepare_price_fields
  end
end
