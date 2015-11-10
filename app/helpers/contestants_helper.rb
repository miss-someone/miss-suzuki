module ContestantsHelper
  # 紹介リンクへのボタンを作成
  def link_btn(contestant_profile)
    return unless contestant_profile.link_url?
    link_to image_tag(btn_name(contestant_profile.link_type)), contestant_profile.link_url, width: 80, target: '_blank'
  end

  def contestant_anchor_url(contestant)
    "/contestants/group/#{contestant.profile.group_id}#contestant-#{contestant.id}"
  end

  def mypage_present?(contestant)
    answers = contestant.interview_answers.each_with_object([]) { |a, obj| obj << a unless a.is_pending }
    imgs = contestant.contestant_images
    answers.present? || imgs.present?
  end

  def link_group_ids(current_page_id)
    ids = (1..Settings.current_open_group_id).to_a
    ids.delete(current_page_id)
    ids
  end

  def remaining_vote_count_text(group_id)
    remaining_vote = current_user.todays_remaining_vote_count(group_id)
    "#{current_user.profile.name}さん，第#{group_id}グループの本日の投票回数残り#{remaining_vote}回です！" if logged_in?
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
