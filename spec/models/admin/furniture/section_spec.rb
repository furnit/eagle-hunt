require 'rails_helper'

RSpec.describe Admin::Furniture::Section, type: :model do
  subject { build :admin_furniture_section }

  include_examples :test_image_container, :admin_furniture_section

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

  describe "#tag" do
    it "is required" do
      subject.tag = nil
      expect(subject).to have_errors_on :tag, errors: :blank
    end
  end
end
