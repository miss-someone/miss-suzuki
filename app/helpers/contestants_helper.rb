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

  def vote_btn(contestant)
    # if !vote_end? and @stage.present? and  @stage == Settings.current_stage
    link_to((image_tag 'kawaii.png', width: 80),
            contestant_vote_path(contestant_id: contestant.id),
            method: :post,
            params: { group_id: contestant.profile.group_id })
    # else
    #  image_tag 'kawaii.png', width: 80
    # end
  end

  def remaining_vote_count_text(group_id)
    if vote_end?
      "<div class='voter_dialog'>予選の投票期間が終了しました。<br>たくさんのご投票ありがとうございました!</div>".html_safe
    else
      return unless logged_in?
      return if current_user.profile.nil?

      remaining_vote = current_user.todays_remaining_vote_count(group_id)
      "<div class='voter_dialog'><span>#{current_user.profile.name}</span>さん，第#{group_id}グループの本日の投票回数は残り<span>#{remaining_vote}回</span>です！<br>他のグループにはもう投票しましたか？</div>".html_safe if logged_in?
    end
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
