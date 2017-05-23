require 'rails_helper'
require 'fileutils'

require Rails.root.join("db", "seeds", "utils")

module Test
  class Image < Admin::Uploader::Image
    self.table_name = "admin_furniture_types"
  end
end

RSpec.describe Admin::Uploader::Image, type: :model do
  subject {
    @start_time ||= Time.now
    Test::Image.new
  }

  before { upload_some_images }

  after {
    idx = subject.images.map { |i| i[:id] }
    Admin::UploadedFile.where("created_at >= ?", @start_time - 1.second).destroy_all
  }

  def fetch_some_image_files
    files = Dir[Rails.root.join("data", "images", "sofa/*.{png,jpg}")]
    expect(files.length).to be > 0
    files
  end

  def upload_some_images
    subject.images = upload_files fetch_some_image_files
    expect(subject.save).to be_truthy
  end

  describe "#images" do

    it "returns multiple images" do
      expect(subject.images.length).to eq Dir[Rails.root.join("data", "images", "sofa/*.{png,jpg}")].length
    end

    context "when images uploaded" do
      it "every images should have a format of {id:, image:}" do
        subject.images.each do |i|
          expect(i).to include(:id)
          expect(i).to include(:image)
        end
      end

      it "every image should exist in `Admin::UploadedFile`" do
        subject.images.each do |i|
          expect(Admin::UploadedFile.where(id: i[:id]).length).to eq 1
        end
      end

      it "every image should be an instance of `ImageUploader`" do
        subject.images.each do |i|
          expect(i[:image]).to be_an(ImageUploader)
        end
      end
    end

    context "when assiging new images" do
      context "when there are no reference to the images" do
        it "removes the previous images and set the new ones" do
          # current images' ID
          idx = subject.images.map { |i| i[:id] }
          # expecting to find the images into database
          expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
          # uploading/replacing new files
          upload_some_images
          # previous images deleted
          expect(Admin::UploadedFile.where(id: idx).length).to eq 0
          # new IDs assigned
          expect(subject.images.map { |i| i[:id] } & idx).to be_empty
        end
      end

      context "when there references to the images" do
        it "won't remove the images from database" do
          # current images' ID
          idx = subject.images.map { |i| i[:id] }
          subject_new = Test::Image.new
          subject_new.images = idx
          # need to be saved to own the images
          subject_new.save
          # expecting to find the images into database
          expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
          # uploading/replacing new files
          upload_some_images
          # previous images won't get deleted because it referenced before
          expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
          # new IDs assigned
          expect(subject_new.images.map { |i| i[:id] } & idx).not_to be_empty
        end

        context "when all references removed" do
          it "then the images get removed from database" do
            # current images' ID
            idx = subject.images.map { |i| i[:id] }
            subject_new = Test::Image.new
            subject_new.images = idx
            # need to be saved to own the images
            subject_new.save
            # expecting to find the images into database
            expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
            # uploading/replacing new files
            upload_some_images
            # previous images won't get deleted because it referenced before
            expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
            # new IDs assigned
            expect(subject_new.images.map { |i| i[:id] } & idx).not_to be_empty
            # remove from
            subject_new.remove_images idx
            # previous images won't get deleted because it referenced before
            expect(Admin::UploadedFile.where(id: idx).length).to eq 0
          end
        end
      end
    end
  end

  describe "#image" do
    it "return the first image" do
      expect(subject.image[:id]).to eq subject.images.first[:id]
    end

    context "when images uploaded" do
      it "the image should have a format of {id:, image:}" do
        expect(subject.image).to include(:id)
        expect(subject.image).to include(:image)
      end

      it "the image should exist in `Admin::UploadedFile`" do
        expect(Admin::UploadedFile.where(id: subject.image[:id]).length).to eq 1
      end

      it "the image should be an instance of `ImageUploader`" do
        expect(subject.image[:image]).to be_an(ImageUploader)
      end
    end

    context "when assiging new image" do
      context "when assigning multiple images" do
        it "raises expcetion" do
          expect { subject.image = upload_files fetch_some_image_files }.to raise_error RuntimeError
        end
      end

      context "when assigning single image" do
        it "it accepts the image" do
          subject.image = upload_files fetch_some_image_files.first
          expect(subject.save).to be_truthy
        end
      end

      context "when there are no reference to the image" do
        it "removes the previous image and set the new ones" do
          # current images' ID
          idx = [subject.image[:id]]
          # expecting to find the images into database
          expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
          # uploading/replacing new files
          subject.image = upload_files fetch_some_image_files.first
          # previous images deleted
          expect(Admin::UploadedFile.where(id: idx).length).to eq 0
          # new IDs assigned
          expect([subject.image[:id]] & idx).to be_empty
        end
      end

      context "when there references to the images" do
        it "won't remove the images from database" do
          # current images' ID
          idx = [subject.image[:id]]
          subject_new = Test::Image.new
          subject_new.image = idx
          # need to be saved to own the images
          subject_new.save
          # expecting to find the images into database
          expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
          # uploading/replacing new files
          subject.image = upload_files fetch_some_image_files.first
          # previous images won't get deleted because it referenced before
          expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
          # new IDs assigned
          expect(subject_new.images.map { |i| i[:id] } & idx).not_to be_empty
        end

        context "when all references removed" do
          it "then the images get removed from database" do
            # current images' ID
            idx = [subject.image[:id]]
            subject_new = Test::Image.new
            subject_new.image = idx
            # need to be saved to own the images
            subject_new.save
            # expecting to find the images into database
            expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
            # uploading/replacing new files
            subject.image = upload_files fetch_some_image_files.first
            # previous images won't get deleted because it referenced before
            expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
            # new IDs assigned
            expect(subject_new.images.map { |i| i[:id] } & idx).not_to be_empty
            # remove from
            subject_new.remove_images idx
            # previous images won't get deleted because it referenced before
            expect(Admin::UploadedFile.where(id: idx).length).to eq 0
          end
        end
      end
    end
  end

  describe "#append_images" do
    it "will effect the list" do
      im = subject.images.dup
      files = fetch_some_image_files
      subject.append_images upload_files files
      expect(subject.images.length).to eq im.length + files.length
    end

    it "will effect the database" do
      im = subject.images.dup
      files = fetch_some_image_files
      subject.append_images upload_files files
      expect(Admin::UploadedFile.where(id: subject.images.map { |i| i[:id] }).length).to eq im.length + files.length
    end

    context "when duplicate" do
      it "won't effect the list" do
        im = subject.images.first
        subject.append_images im[:id]
        expect(subject.images.select { |i| i[:id] == im[:id] }.length).to eq 1
      end

      it "won't duplicate in database (same reference)" do
        im = subject.images.first
        subject.append_images im[:id]
        expect(Admin::UploadedFile.where(id: im[:id]).length).to eq 1
      end
    end

    context "when references to the images" do
      context "when self assigning" do
        it "won't effect the list" do
          # current images' ID
          idx = subject.images.map { |i| i[:id] }
          # append self
          subject.append_images idx
          # save
          subject.save
          # image IDs should not change
          expect(subject.images.map { |i| i[:id] }).to eq idx
        end
      end
    end
  end

  describe "#remove_images" do
    it "is removed from the list" do
      im = subject.images.first
      subject.remove_images im[:id]
      expect(subject.images.select { |i| i[:id] == im[:id] }).to be_empty
    end

    it "is removed from the database" do
      im = subject.images.first
      subject.remove_images im[:id]
      expect(Admin::UploadedFile.where(id: im[:id]).length).to eq 0
    end

    context "when the image's not listed" do
      it "won't effect the list" do
        idx = upload_files fetch_some_image_files
        im = subject.images.dup
        subject.remove_images idx
        expect(subject.images.length).to be im.length
      end

      it "won't effect the database" do
        idx = upload_files fetch_some_image_files
        subject.remove_images idx
        expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
      end
    end

    context "when references to the images" do
      it "won't reference the self assigneds" do
        # current images' ID
        idx = subject.images.map { |i| i[:id] }
        # check the database
        expect(Admin::UploadedFile.where(id: idx).length).to eq idx.length
        # append self
        subject.append_images idx
        # save
        subject.save
        # remove self
        subject.remove_images idx
        # if no reference incremented, it should get deleted from database
        expect(Admin::UploadedFile.where(id: idx).length).to eq 0
      end
    end
  end
end