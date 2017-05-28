require 'rails_helper'

RSpec.describe Admin::Furniture::Fabric::Brand, type: :model do
  subject { build :admin_furniture_fabric_brand }

  describe "#name" do
    it "is required" do
      subject.name = nil
      expect(subject).to have_errors_on :name, errors: :blank
    end

    context "when is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :name, errors: :taken
      end
    end
  end
end
