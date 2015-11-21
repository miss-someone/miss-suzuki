module AdHelper
  def ad_img
    ad = Ad.active.random
    return if ad.blank?
    link_to((image_tag ad.image.url), ad.link_url, target: '_blank')
  end

  def adsense(ad_name = nil)
    ad = Adsense.where(name: ad_name).first
    if ad.present?
      ad.code.html_safe
    else
      ad_img
    end
  end
end
