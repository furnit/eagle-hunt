require 'rails_helper'

RSpec.describe State, type: :model do
  subject { build :state }

  describe "#name" do
    it "is required" do
      subject.name = nil
      expect(subject).to be_invalid_on :name
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
