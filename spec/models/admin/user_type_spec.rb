require 'rails_helper'

RSpec.describe Admin::UserType, type: :model do
  subject { build :admin_user_type }

  describe "#name" do
    it "is required" do
      [nil, "", "\t", " ", "\t\n"].each do |v|
        subject.name = v
        expect(subject).to be_invalid_on :name
      end
    end

    context "when is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to be_invalid_on :name
      end
    end
  end

  describe "#comment" do
    it "is required" do
      [nil, "", "\t", " ", "\t\n"].each do |v|
        subject.comment = v
        expect(subject).to be_invalid_on :comment
      end
    end
  end

  describe "#symbol" do
    it "is required" do
      [nil, "", "\t", " ", "\t\n"].each do |v|
        subject.symbol = v
        expect(subject).to be_invalid_on :symbol
      end
    end

    context "when is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to be_invalid_on :symbol
      end
    end
  end

  describe "#auth_level" do
    it "is required" do
      [nil, "", "\t", " ", "\t\n"].each do |v|
        subject.auth_level = v
        expect(subject).to be_invalid_on :auth_level
      end
    end

    it "accepts greater than zeros" do
      (0..3).each do |l|
        subject.auth_level = l
        expect(subject).to be_valid_on :symbol
      end
    end

    context "when is negative" do
      it "is not valid" do
        (-3..-1).each do |l|
          subject.auth_level = l
          expect(subject).to be_invalid_on :auth_level
        end
      end
    end
  end
end
