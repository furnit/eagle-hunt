require 'rails_helper'

RSpec.describe Admin::Furniture::Set, type: :model do
  subject { build :admin_furniture_set }

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

  describe "#config" do
    it "is required" do
      subject.config = nil
      expect(subject).to have_errors_on :config, errors: :blank
    end

    context "when assigning" do
      before { subject.class.all.destroy_all }
      context "when it is array" do
        it "is valid" do
          subject.config = (1..3).to_a
          expect(subject).to be_valid_on :config
          expect(subject.config).to eq (1..3).to_a
        end
      end

      context "when it is not array" do
        it "process it as string" do
          subject.config = "1, 2, 3"
          expect(subject).to be_valid_on :config
          expect(subject.config).to eq (1..3).to_a
        end
        context "when is not valid array string" do
          it "is not valid" do
            subject.config = "1a, 2, 3"
            expect(subject).to have_errors_on :config, errors: :invalid
          end
        end
      end

      context "when assigning pieces that are not defined in `Admin::Furniture::Piece`" do
        it "is not valid" do
          subject.config = Array.new(3, Admin::Furniture::Piece.maximum(:piece) + 1)
          expect(subject).to have_errors_on :config, errors: :not_defined
        end
      end
    end

    context "when is not unique" do
      it "is not valid" do
        subject.config = [1, 2, 2, 3, 3]
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :config, errors: :taken
        subject.config = [2, 2, 3]
        expect(subject).to be_valid_on :config
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :config, errors: :taken
      end
    end
  end

  describe "#total_count" do
    it "cannot be assigned directly" do
      subject.total_count = 100
      expect(subject.total_count).to be_falsy
    end

    it "returns the #config.sum" do
      subject.config = [1, 2, 3, 3]
      subject.total_count = 1000
      expect(subject.total_count).to eq [1, 2, 3, 3].sum
    end
  end
end
