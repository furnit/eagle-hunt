require 'rails_helper'
require Rails.root.join("spec", "support/shared_examples/pricing")

RSpec.describe Admin::Pricing::Const, type: :model do
  subject { build :admin_pricing_const }

  [:guni, :chasb, :payemobl, :sage, :mikh, :extra].each do |f|
    describe "##{f}" do
      include_examples :pricing, :admin_pricing_const, f
    end
  end
end
