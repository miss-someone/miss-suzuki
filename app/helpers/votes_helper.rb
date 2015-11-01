module VotesHelper
  def cannot_vote_text
    if logged_in?
      'ごめんなさい！<br>今日はもう10回投票しちゃったみたいです・・・'
    else
      'ごめんなさい！<br>ゲストユーザーさんの投票回数は1日3回までみたいです・・・'
    end
  end
end
