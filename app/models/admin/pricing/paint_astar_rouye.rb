class Admin::Pricing::PaintAstarRouye < Admin::Pricing::BaseRecord
  after_initialize do
    prepare_price_fields
  end
  
  validates_presence_of :astare_avaliye, :astare_asli, :rouye, :batune
end
