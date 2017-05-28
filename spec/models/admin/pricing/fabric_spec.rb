require 'rails_helper'
require Rails.root.join("spec", "support/shared_examples/pricing")

RSpec.describe Admin::Pricing::Fabric, type: :model do
  subject { build :admin_pricing_fabric }

  describe "#brand" do
    it "is required" do
      subject.brand = nil
      expect(subject).to have_errors_on :brand, errors: :blank
    end

    context "when it is not valid" do
      it "raises exception" do
        subject.brand = Admin::Furniture::Fabric::Brand.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#price" do
    include_examples :pricing, :admin_pricing_fabric, :price
  end
end
