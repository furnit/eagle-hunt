require 'rails_helper'
require Rails.root.join("spec", "support/shared_examples/pricing")

RSpec.describe Admin::Pricing::Transit, type: :model do
  subject { build :admin_pricing_transit }

  describe "#workshop" do
    it "is required" do
      subject.workshop = nil
      expect(subject).to have_errors_on :workshop, errors: :blank
    end

    context "when it is not valid" do
      it "raises exception" do
        subject.workshop = Admin::Workshop::Workshop.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#state" do
    it "is required" do
      subject.state = nil
      expect(subject).to have_errors_on :state, errors: :blank
    end

    context "when it is not valid" do
      it "raises exception" do
        subject.state = State.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#price" do
    it "is optional" do
      subject.price = nil
      expect(subject).to be_valid_on :price
    end

    context "when is digit" do
      it "it is valid" do
        subject.price = 1200
        expect(subject.price).to eq 1200
        expect(subject).to be_valid_on :price
      end
    end

    context "when is not digit" do
      it "is not valid" do
        subject.price = :string
        expect(subject).to have_errors_on :price, errors: :invalid
      end
    end
  end
end
