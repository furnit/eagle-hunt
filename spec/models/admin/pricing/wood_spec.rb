require 'rails_helper'
require Rails.root.join("spec", "support/shared_examples/pricing")

RSpec.describe Admin::Pricing::Wood, type: :model do
  subject { build :admin_pricing_wood }

  describe "#type" do
    it "is required" do
      subject.type = nil
      expect(subject).to have_errors_on :type, errors: :blank
    end

    context "when it is not valid" do
      it "raises exception" do
        subject.type = Admin::Furniture::Wood::Type.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#price" do
    include_examples :pricing, :admin_pricing_wood, :price
  end
end
