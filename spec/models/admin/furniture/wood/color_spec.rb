require 'rails_helper'

RSpec.describe Admin::Furniture::Wood::Color, type: :model do
  subject { build :admin_furniture_wood_color }

  describe "#name" do
    it "is required" do
      subject.name = nil
      expect(subject).to have_errors_on :name, errors: :blank
    end

    describe "when is not unqiue" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :name, errors: :taken
      end
    end
  end

  describe "#value" do
    it "is required" do
      subject.value = nil
      expect(subject).to have_errors_on :value, errors: :blank
    end

    describe "when is not unqiue" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :value, errors: :taken
      end
    end

    describe "when is not hex-code" do
      it "is not valid" do
        ["1", "12", "1234", "12345", "123456s"].each do |c|
          subject.value = c
          expect(subject).to have_errors_on :value, errors: :invalid
        end
      end
    end

    describe "when is hex-code" do
      it "is valid" do
        ["123", "456", "789", "abc", "def", "012345", "678912", "abcdef"].each do |c|
          subject.value = c
          expect(subject).to be_valid_on :value
        end
      end
    end
  end

  describe "#comment" do
    it "is optional" do
      subject.comment = nil
      expect(subject).to be_valid_on :comment
    end
  end
end
