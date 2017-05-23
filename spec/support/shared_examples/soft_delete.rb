RSpec.shared_examples :test_soft_delete do |param|
  subject { create param }

  describe "#deleted_at" do
    context "before #destroy" do
      it "#deleted_at is nil" do
        expect(subject.deleted?).to be_falsy
      end

      it "gets found by `.find`" do
        expect(subject.class.find(subject.id).id).to eq subject.id
      end
    end

    context "after #destroy" do
      it "flaged as deleted" do
        subject.destroy
        expect(subject.deleted?).not_to be_falsy
      end

      it "won't get found by `.find`" do
        subject.destroy
        expect { subject.class.find(subject.id) }.to raise_error ActiveRecord::RecordNotFound
      end

      it "gets found by `.with_deleted.find`" do
        subject.destroy
        expect(subject.class.with_deleted.find(subject.id).id).to eq subject.id
      end

    end

    context "after #recover" do
      it "is not flagged as deleted" do
        subject.destroy
        expect(subject.deleted?).not_to be_falsy
        subject.recover
        expect(subject.deleted?).to be_falsy
      end

      it "can be found by `.find`" do
        subject.destroy
        expect(subject.deleted?).not_to be_falsy
        subject.class.only_deleted.find(subject.id).recover
        expect(subject.class.find(subject.id).id).to eq subject.id
      end
    end

    context "when really destroyed" do
      context "using #destroy.#destroy" do
        it "is gets deleted for good!" do
          subject.destroy.destroy
          expect { subject.class.with_deleted.find(subject.id) }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context "using #destroy_fully!" do
        it "is gets deleted for good!" do
          subject.destroy_fully!
          expect { subject.class.with_deleted.find(subject.id) }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
  end
end