module ContestantsHelper
  def link(contestant_profile)
    #TODO: リンク判別のメソッド書く
    if contestant_profile.link_url.blank?
      ""
    else
      create_a_tag_link(contestant_profile.link_url, "Facebook")
    end
  end

  private
    def create_a_tag_link(url, name)
      link_to "#{name}はこちら!", url
    end
end
