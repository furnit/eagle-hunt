require 'rails_helper'

RSpec.describe Admin::PushNotification, type: :model do
  subject { build :admin_push_notification }

  describe "#message" do
    it "is required" do
      subject.message = nil
      expect(subject).to have_errors_on :message, errors: :blank
    end
  end

  describe "#category" do
    it "is required" do
      subject.category = nil
      expect(subject).to have_errors_on :category, errors: :blank
    end
  end
end
