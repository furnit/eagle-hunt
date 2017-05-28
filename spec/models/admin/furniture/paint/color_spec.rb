require 'rails_helper'

RSpec.describe Admin::Furniture::Paint::Color, type: :model do
  subject { build :admin_furniture_paint_color }

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

  describe "#brand" do
    it "is required" do
      subject.brand = nil
      expect(subject).to have_errors_on :brand, errors: :blank
    end

    context "when is not valid" do
      it "raises exception" do
        subject.brand = Admin::Furniture::Paint::ColorBrand.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#quality" do
    it "is required" do
      subject.quality = nil
      expect(subject).to have_errors_on :quality, errors: :blank
    end

    context "when is not valid" do
      it "raises exception" do
        subject.quality = Admin::Furniture::Paint::ColorQuality.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey
      end
    end
  end

  describe "#color_value" do
    it "is required" do
      subject.color_value = nil
      expect(subject).to have_errors_on :color_value, errors: :blank
    end

    context "when valid hex-color assigned" do
      context "when number of digits is 6" do
        context "with `#` prefix" do
          it "is valid" do
            subject.color_value = "#373738"
            expect(subject).to be_valid_on :color_value
          end
        end

        context "without `#` prefix" do
          it "is valid" do
            subject.color_value = "373738"
            expect(subject).to be_valid_on :color_value
          end
        end
      end

      context "when number of digits is 3" do
        context "with `#` prefix" do
          it "is not valid" do
            subject.color_value = "#373"
            expect(subject).to be_valid_on :color_value
          end
        end

        context "without `#` prefix" do
          it "is not valid" do
            subject.color_value = "373"
            expect(subject).to be_valid_on :color_value
          end
        end
      end
    end

    context "when invalid hex-color assigned" do
      context "when number of digits is shorter than 6" do
        context "with `#` prefix" do
          it "is not valid" do
            subject.color_value = "#37373"
            expect(subject).to have_errors_on :color_value, errors: :invalid
          end
        end

        context "without `#` prefix" do
          it "is not valid" do
            subject.color_value = "37373"
            expect(subject).to have_errors_on :color_value, errors: :invalid
          end
        end
      end

      context "when number of digits is longer than 6" do
        context "with `#` prefix" do
          it "is not valid" do
            subject.color_value = "#3737381"
            expect(subject).to have_errors_on :color_value, errors: :invalid
          end
        end

        context "without `#` prefix" do
          it "is not valid" do
            subject.color_value = "3737381"
            expect(subject).to have_errors_on :color_value, errors: :invalid
          end
        end
      end

      context "when contains invalid characters" do
        context "with `#` prefix" do
          it "is not valid" do
            subject.color_value = "#213g2f"
            expect(subject).to have_errors_on :color_value, errors: :invalid
          end
        end

        context "without `#` prefix" do
          it "is not valid" do
            subject.color_value = "213g2f"
            expect(subject).to have_errors_on :color_value, errors: :invalid
          end
        end
      end
    end
  end

  describe "#comment" do
    it "is optional" do
      subject.comment = nil
      expect(subject).to be_valid_on :comment
    end
  end
end
