module VotesHelper
  def cannot_vote_text(group_id)
    if logged_in?
      "ごめんなさい！今日はもう第#{group_id}グループに10回投票しちゃったみたいです・・・<br>他のグループには投票しましたか？".html_safe
    else
      "ごめんなさい！ゲストユーザーさんの投票回数は1グループにつき1日3回までみたいです・・・<br>他のグループには投票しましたか？".html_safe
    end
  end
end
