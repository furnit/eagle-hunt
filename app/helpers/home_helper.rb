module HomeHelper
  def get_image images
    image = nil
    images = [images].flatten
    image = images.first[:image] if images.first
    if image == nil
      'No_image_available.svg'
    else
      yield image
    end
  end
  
  def image_url(images, thumb: false)
    get_image images do |image|
      return image.url if not thumb
      return image.thumb.url
    end
  end
  
  def thumbnail_url(images)
    get_image images do |image|
      return image.thumb.url
    end
  end
end
