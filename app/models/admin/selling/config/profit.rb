class Admin::Selling::Config::Profit < Admin::Pricing::BaseRecord
  after_initialize do
    prepare_price_fields
  end
end
