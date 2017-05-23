require 'rails_helper'

RSpec.describe Admin::Furniture::Spec, type: :model do
  subject { build :admin_furniture_spec }

  describe "#name" do
    it "is required" do
      subject.name = nil
      expect(subject).to have_errors_on :name, errors: :blank
    end
  end

  describe "#comment" do
    it "is required" do
      subject.comment = nil
      expect(subject).to have_errors_on :comment, errors: :blank
    end
  end

  describe "#unit" do
    it "is required" do
      subject.unit = nil
      expect(subject).to have_errors_on :unit, errors: :blank
    end
  end
end
