module HomeHelper
  def furniture_image(images)
    image = images
    image = images.first if image.respond_to? :each
    if image == nil
      'No_image_available.svg'
    else
      image.url
    end
  end
end
