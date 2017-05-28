require 'rails_helper'
require Rails.root.join("spec", "support/shared_examples/pricing")

RSpec.describe Admin::Pricing::PaintAstarRouye, type: :model do
  [:astare_avaliye, :astare_asli, :rouye, :batune].each do |f|
    describe "##{f}" do
      include_examples :pricing, :admin_pricing_paint_astar_rouye, f
    end
  end
end
