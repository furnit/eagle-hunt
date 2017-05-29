require 'rails_helper'

RSpec.describe Admin::Selling::Config::DaysToComplete, type: :model do
  subject { build :admin_selling_config_days_to_complete }

  describe "#extra" do
    it "is required" do
      subject.extra = nil
      expect(subject).to have_errors_on :extra, errors: :blank
    end

    context "when assigning zero" do
      it "is valid" do
        subject.extra = 0
        expect(subject.save).to be_truthy
      end
    end

    context "when assigning negative" do
      it "is not valid" do
        subject.extra = -1
        expect(subject).to have_errors_on :extra, errors: :greater_than_or_equal_to
      end
    end

    context "when assigning positive" do
      it "is valid" do
        subject.extra = 1
        expect(subject.save).to be_truthy
      end
    end

    context "when assigning numerical" do
      it "is valid" do
        subject.extra = "1"
        expect(subject.save).to be_truthy
      end
    end
  end
end
