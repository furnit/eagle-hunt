require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build :profile }

  describe "#first_name" do
    it "is required" do
      subject.first_name = nil
      expect(subject).to have_errors_on :first_name, errors: :blank
    end

    context "when assigning abraic name" do
      it "is valid" do
        subject.first_name = "داریوش"
        expect(subject).to be_valid_on :first_name
      end
    end

    context "when assigning latin name" do
      it "is not valid" do
        subject.first_name = "John"
        expect(subject).to have_errors_on :first_name, errors: :not_persian
      end
    end
  end

  describe "#last_name" do
    it "is required" do
      subject.last_name = nil
      expect(subject).to have_errors_on :last_name, errors: :blank
    end

    context "when assigning abraic name" do
      it "is valid" do
        subject.last_name = "حسن‌پور آده"
        expect(subject).to be_valid_on :last_name
      end
    end

    context "when assigning latin name" do
      it "is not valid" do
        subject.last_name = "John"
        expect(subject).to have_errors_on :last_name, errors: :not_persian
      end
    end
  end

  describe "#address" do
    it "is required" do
      subject.address = nil
      expect(subject).to have_errors_on :address, errors: :blank
    end

    context "when assigning abraic name" do
      it "is valid" do
        subject.address = "تهران، خیابان ولیعصر"
        expect(subject).to be_valid_on :address
      end
    end

    context "when assigning latin name" do
      it "is not valid" do
        subject.address = "John"
        expect(subject).to have_errors_on :address, errors: :not_persian
      end
    end
  end

  describe "#postal_code" do
    it "is not required" do
      subject.postal_code = nil
      expect(subject).to be_valid_on :postal_code
    end

    it "normalizes itself on validation" do
      subject.postal_code = "12-345-678 90"
      expect(subject).to be_valid_on :postal_code
      expect(subject.postal_code).to eq "1234567890"
    end

    context "when assigning numerical" do
      it "is valid" do
        subject.postal_code = "1" * 10
        expect(subject).to be_valid_on :postal_code
      end
    end

    context "when assigning greater than 10 digit" do
      it "is not valid" do
        subject.postal_code = "1" * 11
        expect(subject).to have_errors_on :postal_code, errors: :wrong_length
      end
    end

    context "when assigning less than 10 digit" do
      it "is not valid" do
        subject.postal_code = "1" * 9
        expect(subject).to have_errors_on :postal_code, errors: :wrong_length
      end
    end

    context "when assigning anything but numerical" do
      it "is valid" do
        subject.postal_code = "1a" * 5
        expect(subject).to have_errors_on :postal_code, errors: :not_a_number
      end
    end
  end

  describe "#state" do
    it "is required" do
      subject.state = nil
      expect(subject).to have_errors_on :state, errors: :blank
    end

    context "when setting wrong #state" do
      before { subject.state = State.new(id: -1001) }

      it "is valid" do
        expect(subject).to be_valid_on :state
      end

      it "will raise an exception on save" do
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#user" do
    it "is required" do
      subject.state = nil
      expect(subject).to have_errors_on :state, errors: :blank
    end

    context "when setting wrong #user" do
      before { subject.user = User.new(id: -1001) }

      it "is valid" do
        expect(subject).to be_valid_on :user
      end

      it "will raise an exception on save" do
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end

    context "when duplicate #user" do
      it "will raise an exception on save" do
        expect(subject.save).to be_truthy
        expect { subject.dup.save }.to raise_error ActiveRecord::RecordNotUnique
      end
    end
  end

  describe "#full_name" do
    it "consists of #first_name and #last_name" do
      expect(subject.full_name).to eq "#{subject.first_name} #{subject.last_name}"
    end

    context "when it get assigned" do
      it "will split the input into first_name and last_name" do
        subject.full_name = "داریوش حسن‌پور آده"
        expect(subject.first_name).to eq "داریوش"
        expect(subject.last_name).to eq "حسن‌پور آده"
      end
    end
  end
end
