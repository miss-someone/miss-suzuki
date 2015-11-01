class NewsController < ApplicationController
  skip_before_filter :require_login, only: :index
  def index
    @news = News.order("date DESC")
  end
end
