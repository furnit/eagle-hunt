class Admin::Pricing::Foam < Admin::Pricing::BaseRecord
  after_initialize do
    prepare_price_fields
  end
  
  validates_uniqueness_of :admin_furniture_foam_type_id
  belongs_to :type, class_name: '::Admin::Furniture::Foam::Type', foreign_key: :admin_furniture_foam_type_id
end
