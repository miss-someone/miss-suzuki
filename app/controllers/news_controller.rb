class NewsController < ApplicationController
  def index
    @news = News.order("date DESC")
  end
end
