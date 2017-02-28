module HomeHelper
  def furniture_image(image)
    if image[0] == nil
      'No_image_available.svg'
    else
      image[0].url
    end
  end
end
