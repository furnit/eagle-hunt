require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "#email" do
    it "is not required" do
      expect(subject.email_required?).to be_falsey
      subject.email = nil
      expect(subject).to be_valid_on :email
    end
  end

  describe "#phone_number" do
    it "is required" do
      subject.phone_number = nil
      expect(subject).to be_invalid_on :phone_number
    end

    it "is normalized on initialization" do
      u = User.new(phone_number: "0912 1234 567", password: "123456", password_confirmation: "123456")
      expect(u).to be_valid
      expect(u.phone_number).to eq "09121234567"
      expect(subject).to be_valid
    end

    it "is normalized on validation" do
      u = build(:user, phone_number: "0912-123-4567")
      expect(u).to be_valid
      expect(u.phone_number).to eq "09121234567"
      expect(subject).to be_valid
    end

    context "when is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :phone_number, errors: :taken
      end
    end

    context "when is not mobile number" do
      it "is not valid for not numerics" do
        subject.phone_number = "0" + "a1" * 5
        expect(subject.dup).to have_errors_on :phone_number, errors: :invalid
      end

      it "is not valid for short number" do
        subject.phone_number = "091212345"
        expect(subject.dup).to have_errors_on :phone_number, errors: :wrong_length
      end

      it "is not valid for long number" do
        subject.phone_number = "09121234567891011"
        expect(subject.dup).to have_errors_on :phone_number, errors: :wrong_length
      end

      it "is not valid for not state phone number" do
        subject.phone_number = "021888844443"
        expect(subject.dup).to have_errors_on :phone_number, errors: :invalid
      end
    end
  end

  describe "#reset_password" do
    it "resets `#password` to `#phone_number`" do
      expect(subject.password).not_to eq subject.phone_number
      subject.reset_password
      expect(subject.password).to eq subject.phone_number
    end

    it "resets `#password_confirmation` to `#phone_number`" do
      expect(subject.password_confirmation).not_to eq subject.phone_number
      subject.reset_password
      expect(subject.password_confirmation).to eq subject.phone_number
    end

    it "flags `#change_password` to be true" do
      expect(subject.change_password).not_to be_truthy
      subject.reset_password
      expect(subject.change_password).to be_truthy
    end

    it "does not save the subject automatically" do
      expect(subject.new_record?).to be_truthy
      subject.reset_password
      expect(subject.new_record?).to be_truthy
    end
  end

  describe "#reset_two_step_auth" do
    it "resets `#two_step_auth*`" do
      attribs = subject.attributes.select { |i| i =~ /two_step_auth.*/ }
      attribs.each { |f, _| expect(subject[f]).to be_falsey }
      attribs.each { |f, _| subject[f] = Time.now }
      attribs.each { |f, _| expect(subject[f]).not_to be_falsey }
      subject.reset_two_step_auth
      attribs.each { |f, _| expect(subject[f]).to be_falsey }
    end
  end

  describe "#is_added_to_phonebook" do
    it "is initially nil" do
      expect(subject.is_added_to_phonebook).to be_falsey
    end
  end

  describe "#error_on_add_to_phonebook" do
    it "is initially nil" do
      expect(subject.error_on_add_to_phonebook).to be_falsey
    end
  end

  describe "#deleted_at" do
    it "is initially nil" do
      expect(subject.deleted_at).to be_falsey
    end
  end

  describe "#confirmation_token" do
    it "is initially nil" do
      expect(subject.confirmation_token).to be_falsey
    end
  end

  describe "#confirmation_sent_at" do
    it "is initially nil" do
      expect(subject.confirmation_sent_at).to be_falsey
    end
  end

  describe "#failed_attempts" do
    it "is initially 0" do
      expect(subject.failed_attempts).to eq 0
    end
  end

  describe "#unlock_token" do
    it "is initially nil" do
      expect(subject.unlock_token).to be_falsey
    end
  end

  describe "#blocked_at" do
    it "is initially nil" do
      expect(subject.blocked_at).to be_falsey
    end
  end

  describe "#unlock_token" do
    it "is initially nil" do
      expect(subject.unlock_token).to be_falsey
    end
  end

  describe "#creator_user_id" do
    it "is initially nil" do
      expect(subject.unlock_token).to be_falsey
    end
  end

  describe "#type" do
    it "is initially a `:CLIENT` type" do
      expect(subject.type.symbol.to_sym).to eq :CLIENT
    end

    context "when setting invalid type" do
      it "will raise an exception on save" do
        subject.admin_user_type_id = 1000
        expect { subject.save }.to raise_error(ActiveRecord::InvalidForeignKey, /.*FOREIGN KEY \(`admin_user_type_id`\) REFERENCES `admin_user_types` \(`id`\).*/)
      end
    end
  end
end
