module AdHelper
  def ad_img
    ad = Ad.active.random
    return if ad.blank?
    image_tag ad.image.url
  end
end
