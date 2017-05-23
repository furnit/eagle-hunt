require 'rails_helper'

RSpec.describe Admin::Furniture::BuildDetail, type: :model do
  subject { build :admin_furniture_build_detail }

  describe "#section" do
    it "is required" do
      subject.admin_furniture_section_id = nil
      expect(subject).to have_errors_on :section, errors: :blank
    end
  end

  describe "#spec" do
    it "is required" do
      subject.spec = nil
      expect(subject).to have_errors_on :spec, errors: :blank
    end
  end

  describe "#value" do
    it "is required" do
      subject.value = nil
      expect(subject).to have_errors_on :value, errors: :blank
    end
  end
end
