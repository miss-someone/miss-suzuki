module VotesHelper
  def cannot_vote_text(group_id)
    if logged_in?
      "ごめんなさい！今日はもう10回投票しちゃったみたいです・・・".html_safe
    else
      "ごめんなさい！ゲストユーザーさんの投票回数は1日3回までみたいです・・・".html_safe
    end
  end
end
