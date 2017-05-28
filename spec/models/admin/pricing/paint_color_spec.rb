require 'rails_helper'
require Rails.root.join("spec", "support/shared_examples/pricing")

RSpec.describe Admin::Pricing::PaintColor, type: :model do
  subject { build :admin_pricing_paint_color }

  describe "#brand" do
    it "is required" do
      subject.brand = nil
      expect(subject).to have_errors_on :brand, errors: :blank
    end

    context "when it is not valid" do
      it "raises exception" do
        subject.brand = Admin::Furniture::Paint::ColorBrand.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#price" do
    include_examples :pricing, :admin_pricing_paint_color, :price
  end
end
