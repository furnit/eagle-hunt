class Admin::Selling::Config::Price < ApplicationRecord
  belongs_to :set, class_name: "::Admin::Furniture::Set", foreign_key: :admin_furniture_set_id
  belongs_to :wood, class_name: "::Admin::Furniture::Wood::Type", foreign_key: :admin_furniture_wood_type_id
  belongs_to :furniture, class_name: "::Admin::Furniture::Furniture", foreign_key: :admin_furniture_furniture_id
  belongs_to :fabric_brand, class_name: "::Admin::Furniture::Fabric::Brand", foreign_key: :admin_furniture_fabric_brand_id
  belongs_to :paint_color, class_name: "::Admin::Furniture::Paint::ColorBrand", foreign_key: :admin_furniture_paint_color_brand_id

  # don't validate presence of the attributes, introduced from commit@13426a0
  #   the issue raised testing the site from at commit@1b64071 which the at the method
  #   `Admin::Selling::Config::PricesController.set_admin_selling_config_price()` when trying to `.find_or_create()` this model
  #   validation will fail and the site won't perform!
  # validates_presence_of :overall_cost, :set, :wood, :fabric_brand, :furniture, :paint_color
  validate :cost_details_validation
  validates_uniqueness_of :furniture

  private
    def cost_details_validation
      if not cost_details.nil?
        cost_details.values.each do |d|
          if not d.is_a?(Numeric)
            errors.add(:cost_details, :not_a_number)
          elsif d < 0
            errors.add(:cost_details, :greater_or_equal_than)
          end
        end
      end
    end

end
