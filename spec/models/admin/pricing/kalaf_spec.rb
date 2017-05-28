require 'rails_helper'
require Rails.root.join("spec", "support/shared_examples/pricing")

RSpec.describe Admin::Pricing::Kalaf, type: :model do
  subject { build :admin_pricing_kalaf }

  describe "#price" do
    include_examples :pricing, :admin_pricing_fabric, :price
  end
end