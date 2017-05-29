require 'rails_helper'

RSpec.describe Admin::Selling::Config::PiecePrice, type: :model do
  subject { build :admin_selling_config_piece_price }

  describe "#percentage" do
    it "is required" do
      subject.percentage = nil
      expect(subject).to have_errors_on :percentage, errors: :blank
    end

    context "when is in range of [0, 1]" do
      context "when is digital" do
        it "is valid" do
          (0..1000).each do |i|
            subject.percentage = i / 1000
            expect(subject).to be_valid_on :percentage
          end
        end
      end

      context "when is numerical" do
        it "is valid" do
          (0..1000).each do |i|
            subject.percentage = (i / 1000).to_s
            expect(subject).to be_valid_on :percentage
          end
        end
      end
    end

    context "when is out of range of [0, 1]" do
      context "when is digital" do
        it "is valid" do
          (-10..10).each do |i|
            next if i.between? 0, 1
            subject.percentage = i
            expect(subject).to have_errors_on :percentage, errors: :inclusion
          end
        end
      end

      context "when is numerical" do
        it "is valid" do
          (-10..10).each do |i|
            next if i.between? 0, 1
            subject.percentage = i.to_s
            expect(subject).to have_errors_on :percentage, errors: :inclusion
          end
        end
      end
    end
  end

  describe "#set" do
    it "is required" do
      subject.set = nil
      expect(subject).to have_errors_on :set, errors: :blank
    end

    context "when is not valid" do
      it "raises exception" do
        subject.set = Admin::Furniture::Set.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::RecordNotFound, /.*Couldn't find Admin::Furniture::Set with.*/
      end
    end
  end

  describe "#piece" do
    it "is required" do
      subject.piece = nil
      expect(subject).to have_errors_on :piece, errors: :blank
    end

    context "when is not valid" do
      it "raises exception" do
        subject.piece = Admin::Furniture::Piece.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end
end
