class Admin::Pricing::PaintColor < Admin::Pricing::BaseRecord
  after_initialize do
    prepare_price_fields
  end
  
  validates_presence_of :brand, :price
  validates_uniqueness_of :brand
  belongs_to :brand, class_name: '::Admin::Furniture::Paint::ColorBrand', foreign_key: :admin_furniture_paint_color_brand_id
end
