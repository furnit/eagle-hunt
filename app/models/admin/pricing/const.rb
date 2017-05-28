class Admin::Pricing::Const < Admin::Pricing::BaseRecord
  after_initialize do
    prepare_price_fields
  end
  
  validates_presence_of :guni, :chasb, :payemobl, :sage, :mikh, :extra
end
