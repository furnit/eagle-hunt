require 'rails_helper'

RSpec.describe Admin::Furniture::Furniture, type: :model do
  subject { build :admin_furniture_furniture }

  describe "#name" do
    it "is required" do
      next
      subject.name = nil
      expect(subject).to have_errors_on :name, errors: :blank
    end
  end
end
