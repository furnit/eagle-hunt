class Admin::Pricing::Transit < Admin::Pricing::BaseRecord
  after_initialize do
    prepare_price_fields
  end
  
  belongs_to :workshop, class_name: '::Admin::Workshop::Workshop', foreign_key: :admin_workshop_workshop_id
  belongs_to :state
  
  validates_presence_of :workshop, :state
  validates_uniqueness_of :workshop, scope: :state
end
