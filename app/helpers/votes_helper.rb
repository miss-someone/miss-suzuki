module VotesHelper
  def cannot_vote_text(group_id)
    if logged_in?
      "ごめんなさい！<br>今日はもう第#{group_id}グループに10回投票しちゃったみたいです・・・".html_safe
    else
      "ごめんなさい！<br>ゲストユーザーさんの投票回数は1グループにつき1日3回までみたいです・・・".html_safe
    end
  end
end
