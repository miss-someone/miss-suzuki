module ContestantsHelper
  # 紹介リンクへのボタンを作成
  def link_btn(contestant_profile)
    return unless contestant_profile.link_url?
    link_to image_tag(btn_name(contestant_profile.link_type)), contestant_profile.link_url, width: 80
  end

  def is_mypage_present?(contestant)
    answers = InterviewAnswer.where(user_id: contestant.profile.user_id,
                                    is_pending: false)
    imgs = ContestantImage.where(user_id: contestant.profile.user_id)
    answers.present? || imgs.present?
  end

  private

  # リンク種別から表示するボタン画像のファイル名を取得する
  def btn_name(link_type)
    case link_type
    when Settings.link_type[:facebook] then
      'btn/btn_fb.png'
    when Settings.link_type[:twitter] then
      'btn/btn_tw.png'
    when Settings.link_type[:instagram] then
      'btn/btn_insta.png'
    when Settings.link_type[:movie] then
      'btn/btn_movie.png'
    when Settings.link_type[:blog] then
      'btn/btn_blog.png'
    else
      'btn/btn_site.png'
    end
  end
end
