require 'rails_helper'

RSpec.describe Admin::Furniture::Piece, type: :model do
  subject { build :admin_furniture_piece }

  describe "#piece" do
    it "is required" do
      subject.piece = nil
      expect(subject).to have_errors_on :piece, errors: :blank
    end

    it "contains only integer" do
      subject.piece = 1.8
      expect(subject.piece).to be 1
    end

    context "when is not positive" do
      it "is not valid" do
        (-1..0).each do |p|
          subject.piece = p
          expect(subject).to have_errors_on :piece, errors: :greater_than
        end
      end
    end

    context "when is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :piece, errors: :taken
      end
    end
  end

  describe "#comment" do
    it "is required" do
      subject.comment = nil
      expect(subject).to have_errors_on :comment, errors: :blank
    end
  end
end
