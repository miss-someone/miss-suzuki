module AdHelper
  def ad_img
    ad = Ad.active.random
    return if ad.blank?
    link_to (image_tag ad.image.url), ad.link_url, target: '_blank'
  end
end
