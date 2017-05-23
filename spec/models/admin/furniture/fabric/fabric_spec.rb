require 'rails_helper'
require Rails.root.join("spec", "support/shared_examples/soft_delete");

RSpec.describe Admin::Furniture::Fabric::Fabric, type: :model do
  subject { build :admin_furniture_fabric_fabric }

  include_examples :test_image_container, :admin_furniture_fabric_fabric

  describe "#brand" do
    it "is required" do
      subject.brand = nil
      expect(subject).to have_errors_on :brand, errors: :blank
    end
  end

  describe "#quality" do
    it "is required" do
      subject.quality = nil
      expect(subject).to have_errors_on :quality, errors: :blank
    end
  end

  describe "when [#brand & #quality] is not unique" do
    it "is not valid" do
      expect(subject.save).to be_truthy
      expect(subject.dup).to have_errors_on :brand, errors: :taken
    end
  end

  include_examples :test_soft_delete, :admin_furniture_fabric_fabric
end
