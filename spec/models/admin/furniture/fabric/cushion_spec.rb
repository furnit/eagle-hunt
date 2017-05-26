require 'rails_helper'

RSpec.describe Admin::Furniture::Fabric::Cushion, type: :model do
  subject { build :admin_furniture_fabric_cushion }

  describe "#label" do
    it "is required" do
      subject.label = nil
      expect(subject).to have_errors_on :label, errors: :blank
    end

    context "when is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :label, errors: :taken
      end
    end
  end

  describe "#width" do
    it "is required" do
      subject.width = nil
      expect(subject).to have_errors_on :width, errors: :blank
    end

    context "when is not positive" do
      it "is not valid" do
        (-2..0).each do |i|
          subject.width = i
          expect(subject).to have_errors_on :width, errors: :invalid
        end
      end
    end
  end

  describe "#height" do
    it "is required" do
      subject.height = nil
      expect(subject).to have_errors_on :height, errors: :blank
    end

    context "when is not positive" do
      it "is not valid" do
        (-2..0).each do |i|
          subject.height = i
          expect(subject).to have_errors_on :height, errors: :invalid
        end
      end
    end
  end

  describe "[#width, #height]" do
    context "when is not unqiue" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :height, errors: :taken
      end
    end
  end
end
