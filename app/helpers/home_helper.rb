module HomeHelper
  def image_url(images, thumb: false)
    image = images
    image = images.first if image.respond_to? :each
    if image == nil
      'No_image_available.svg'
    else
      return image.url if not thumb
      return image.thumb.url
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
