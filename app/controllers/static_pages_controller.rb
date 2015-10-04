class StaticPagesController < ApplicationController
  # トップページ
  def index
    @news = News.where("is_important = 'true'").order("date DESC").limit(5)
    @contestants = Contestant.todays_preopen
  end

  # News
  def news
  end
end
