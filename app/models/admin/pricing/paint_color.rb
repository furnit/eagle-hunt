class Admin::Pricing::PaintColor < Admin::Pricing::BaseRecord
  after_initialize do
    prepare_price_fields
  end
  
  validates_uniqueness_of :admin_furniture_paint_color_brand_id
  belongs_to :brand, class_name: '::Admin::Furniture::PaintColorBrand', foreign_key: :admin_furniture_paint_color_brand_id
end
