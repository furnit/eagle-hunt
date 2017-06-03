require 'rails_helper'

RSpec.describe Admin::Selling::Config::Price, type: :model do
  subject { build :admin_selling_config_price }

  describe "#overall_cost" do
    it "is required" do
      subject.overall_cost = nil
      expect(subject).to have_errors_on :overall_cost, errors: :blank
    end

    context "when is negative" do
      it "is not valid" do
        subject.overall_cost = -1
        expect(subject).to have_errors_on :overall_cost, errors: :greater_than
      end
    end
  end

  describe "#wood" do
    it "is required" do
      subject.wood = nil
      expect(subject).to have_errors_on :wood, errors: :blank
    end
  end

  describe "#fabric" do
    it "is required" do
      subject.fabric = nil
      expect(subject).to have_errors_on :fabric, errors: :blank
    end
  end

  describe "#furniture" do
    it "is required" do
      subject.furniture = nil
      expect(subject).to have_errors_on :furniture, errors: :blank
    end
  end

  describe "#paint_color" do
    it "is required" do
      subject.paint_color = nil
      expect(subject).to have_errors_on :paint_color, errors: :blank
    end
  end
end
