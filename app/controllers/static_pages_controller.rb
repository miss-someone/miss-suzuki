class StaticPagesController < ApplicationController
  # トップページ
  def index
    @news = News.where("is_important = 'true'").order("date DESC").limit(5)
    # プレ公開の出場者を取得
    @contestants = Contestant.todays_preopen
  end

  # News
  def news
  end
end
