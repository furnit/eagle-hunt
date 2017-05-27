require 'rails_helper'

RSpec.describe Admin::Furniture::Fabric::Color, type: :model do
  subject { build :admin_furniture_fabric_color }

  describe "#name" do
    it "is optional" do
      subject.name = nil
      expect(subject).to be_valid_on :name
    end

    context "when is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :name, errors: :taken
      end
    end
  end

  describe "#value" do
    it "is required" do
      subject.value = nil
      expect(subject).to have_errors_on :value, errors: :blank
    end

    context "when valid hex-color assigned" do
      context "when number of digits is 6" do
        context "with `#` prefix" do
          it "is valid" do
            subject.value = "#373738"
            expect(subject).to be_valid_on :value
          end
        end

        context "without `#` prefix" do
          it "is valid" do
            subject.value = "373738"
            expect(subject).to be_valid_on :value
          end
        end
      end

      context "when number of digits is 3" do
        context "with `#` prefix" do
          it "is not valid" do
            subject.value = "#373"
            expect(subject).to be_valid_on :value
          end
        end

        context "without `#` prefix" do
          it "is not valid" do
            subject.value = "373"
            expect(subject).to be_valid_on :value
          end
        end
      end
    end

    context "when invalid hex-color assigned" do
      context "when number of digits is shorter than 6" do
        context "with `#` prefix" do
          it "is not valid" do
            subject.value = "#37373"
            expect(subject).to have_errors_on :value, errors: :invalid
          end
        end

        context "without `#` prefix" do
          it "is not valid" do
            subject.value = "37373"
            expect(subject).to have_errors_on :value, errors: :invalid
          end
        end
      end

      context "when number of digits is longer than 6" do
        context "with `#` prefix" do
          it "is not valid" do
            subject.value = "#3737381"
            expect(subject).to have_errors_on :value, errors: :invalid
          end
        end

        context "without `#` prefix" do
          it "is not valid" do
            subject.value = "3737381"
            expect(subject).to have_errors_on :value, errors: :invalid
          end
        end
      end

      context "when contains invalid characters" do
        context "with `#` prefix" do
          it "is not valid" do
            subject.value = "#213g2f"
            expect(subject).to have_errors_on :value, errors: :invalid
          end
        end

        context "without `#` prefix" do
          it "is not valid" do
            subject.value = "213g2f"
            expect(subject).to have_errors_on :value, errors: :invalid
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

  describe "#model" do
    it "is required" do
      subject.model = nil
      expect(subject).to have_errors_on :model, errors: :blank
    end

    context "when format is proper" do
      it "is valid" do
        subject.model = { k: 1, init: [[12]], runs: 1}
        expect(subject).to be_valid_on :model
      end
    end

    context "when format is not proper" do
      context "when is not Hash" do
        it "is not valid" do
          [nil, [], "", 123].each do |val|
            subject.model = val
            expect(subject).to have_errors_on :model, errors: :invalid
          end
        end
      end

      context "when a necessary key is missing from hash" do
        context "when `:k` does not exist" do
          it "is not valid" do
            subject.model.delete :k.to_s
            expect(subject).to have_errors_on :model, errors: :invalid
          end
        end

        context "when `:init` does not exist" do
          it "is not valid" do
            subject.model.delete :init.to_s
            expect(subject).to have_errors_on :model, errors: :invalid
          end
        end

        context "when `:runs` does not exist" do
          it "is not valid" do
            subject.model.delete :runs.to_s
            expect(subject).to have_errors_on :model, errors: :invalid
          end
        end
      end

      context "when `:k` is not in sync with `:init`" do
        it "is not valid" do
          expect(subject).to be_valid_on :model
          subject.model["k"] += 1
          expect(subject).to have_errors_on :model, errors: :invalid
          subject.model["init"] += [21]
          expect(subject).to be_valid_on :model
        end
      end
    end
  end
end
