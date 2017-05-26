require 'rails_helper'

RSpec.describe Admin::Furniture::Fabric::ModelColor, type: :model do
  subject { build :admin_furniture_fabric_model_color }

  describe "#model" do
    it "is required" do
      subject.model = nil
      expect(subject).to have_errors_on :model, errors: :blank
    end
  end

  describe "#color" do
    it "is required" do
      subject.color = nil
      expect(subject).to have_errors_on :color, errors: :blank
    end
  end

  describe "[#model, #color]" do
    context "when is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :model, errors: :taken
        subject.color = create :admin_furniture_fabric_color
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :model, errors: :taken
      end
    end
  end

end
