class StaticPagesController < ApplicationController
  # トップページ
  def index
    @news = News.where("is_important = 'true'").order("date DESC")
  end

  # News
  def news
  end
end
