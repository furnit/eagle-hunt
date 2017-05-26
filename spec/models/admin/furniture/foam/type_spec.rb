require 'rails_helper'

RSpec.describe Admin::Furniture::Foam::Type, type: :model do
  subject { build :admin_furniture_foam_type }

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
end
