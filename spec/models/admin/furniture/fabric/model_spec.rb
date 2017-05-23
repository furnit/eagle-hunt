require 'rails_helper'

RSpec.describe Admin::Furniture::Fabric::Model, type: :model do
  subject { build :admin_furniture_fabric_model }

  include_examples :test_image_container, :admin_furniture_fabric_model

  describe "#name" do
    context "when [#name, #fabric] is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :name, errors: :taken
      end
    end
  end

  describe "#fabric" do
    it "is required" do
      subject.fabric = nil
      expect(subject).to have_errors_on :fabric, errors: :blank
    end
  end
end
