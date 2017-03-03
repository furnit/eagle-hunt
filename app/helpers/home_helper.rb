module HomeHelper
  def image_url(images)
    image = images
    image = images.first if image.respond_to? :each
    if image == nil
      'No_image_available.svg'
    else
      image.url
    end
  end
  def thumbnail_url(images)
    image = images
    image = images.first if image.respond_to? :each
    if image == nil
      'No_image_available.svg'
    else
      image.thumb.url
    end
  end  
end
