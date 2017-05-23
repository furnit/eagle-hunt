require 'rails_helper'
require Rails.root.join("spec", "support/shared_examples/soft_delete");

RSpec.describe Admin::Furniture::Type, type: :model do
  subject { create :admin_furniture_type }

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

  include_examples :test_soft_delete, :admin_furniture_type
end
