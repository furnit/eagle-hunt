RSpec.shared_examples :pricing do |param, field|
  subject { build param }

  it "is required" do
    subject.send("#{field}=", nil)
    expect(subject).to have_errors_on field, errors: :blank
  end

  context "when is digit" do
    it "it is valid" do
      subject.send("#{field}=", 1200)
      expect(subject.send("#{field}")).to eq 1200
      expect(subject).to be_valid_on field
    end
  end

  context "when is not digit" do
    it "is not valid" do
      subject.send("#{field}=", :string)
      expect(subject).to have_errors_on field, errors: :invalid
    end
  end
end