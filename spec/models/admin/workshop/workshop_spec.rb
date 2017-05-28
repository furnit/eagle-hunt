require 'rails_helper'

RSpec.describe Admin::Workshop::Workshop, type: :model do
  subject { build :admin_workshop_workshop }

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

  describe "#address" do
    it "is required" do
      subject.address = nil
      expect(subject).to have_errors_on :address, errors: :blank
    end
  end

  describe "#manager" do
    it "is required" do
      subject.manager = nil
      expect(subject).to have_errors_on :manager, errors: :blank
    end

    context "when is not valid" do
      it "is not valid" do
        subject.manager = User.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#state" do
    it "is required" do
      subject.state = nil
      expect(subject).to have_errors_on :state, errors: :blank
    end

    context "when is not valid" do
      it "is not valid" do
        subject.state = State.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#phone_number" do
    it "is required" do
      subject.phone_number = nil
      expect(subject).to have_errors_on :phone_number, errors: :blank
    end

    context "when it is OK" do
      it "is valid" do
        subject.phone_number = "02112345678"
        expect(subject).to be_valid_on :phone_number
      end
    end

    context "when it has shorter length" do
      it "is not valid" do
        subject.phone_number = "0211234567"
        expect(subject).to have_errors_on :phone_number, errors: :wrong_length
      end
    end

    context "when it has longer length" do
      it "is not valid" do
        subject.phone_number = "021123456789"
        expect(subject).to have_errors_on :phone_number, errors: :wrong_length
      end
    end

    context "when is it does not contain valid area code" do
      it "is not valid" do
        subject.phone_number = "12112345678"
        expect(subject).to have_errors_on :phone_number, errors: :invalid
      end
    end
  end

  describe "#ceased_at" do
    it "is initially nil" do
      expect(subject.save).to be_truthy
      subject.reload
      expect(subject.ceased_at).to be_falsy
    end
  end
end
