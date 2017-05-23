RSpec.shared_examples :test_image_container do |param|
  subject { build param }

  it "is an image container (can hold image uploads)" do
    expect(subject).to be_a(Admin::Uploader::Image)
  end
end