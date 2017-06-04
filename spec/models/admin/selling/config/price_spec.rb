require 'rails_helper'

RSpec.describe Admin::Selling::Config::Price, type: :model do
  subject { build :admin_selling_config_price }

  describe "#overall_cost" do
    it "is required" do
      subject.overall_cost = nil
      expect(subject).to have_errors_on :overall_cost, errors: :blank
    end

    context "when is negative" do
      it "is not valid" do
        subject.overall_cost = -1
        expect(subject).to have_errors_on :overall_cost, errors: :greater_than
      end
    end
  end

  describe "#wood" do
    it "is required" do
      subject.wood = nil
      expect(subject).to have_errors_on :wood, errors: :blank
    end

    context "when is not valid" do
      it "raises exception" do
        subject.wood = Admin::Furniture::Wood::Type.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey, /.*FOREIGN KEY \(`admin_furniture_wood_type_id`\) REFERENCES `admin_furniture_wood_types` \(`id`\).*/
      end
    end
  end

  describe "#fabric_brand" do
    it "is required" do
      subject.fabric_brand = nil
      expect(subject).to have_errors_on :fabric_brand, errors: :blank
    end

    context "when is not valid" do
      it "raises exception" do
        subject.fabric_brand = Admin::Furniture::Fabric::Brand.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey, /.*FOREIGN KEY \(`admin_furniture_fabric_brand_id`\) REFERENCES `admin_furniture_fabric_brands` \(`id`\).*/
      end
    end
  end

  describe "#paint_color" do
    it "is required" do
      subject.paint_color = nil
      expect(subject).to have_errors_on :paint_color, errors: :blank
    end

    context "when is not valid" do
      it "raises exception" do
        subject.paint_color = Admin::Furniture::Paint::ColorBrand.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey, /.*FOREIGN KEY \(`admin_furniture_paint_color_brand_id`\) REFERENCES `admin_furniture_paint_color_brands` \(`id`\).*/
      end
    end
  end

  describe "#furniture" do
    it "is required" do
      subject.furniture = nil
      expect(subject).to have_errors_on :furniture, errors: :blank
    end

    context "when is not valid" do
      it "raises exception" do
        subject.furniture = Admin::Furniture::Furniture.new(id: -1)
        expect { subject.save }.to raise_error ActiveRecord::InvalidForeignKey, /.*FOREIGN KEY \(`admin_furniture_furniture_id`\) REFERENCES `admin_furniture_furnitures` \(`id`\).*/
      end
    end

    context "when is not unique" do
      it "is not valid" do
        expect(subject.save).to be_truthy
        expect(subject.dup).to have_errors_on :furniture, errors: :taken
      end
    end
  end
end
