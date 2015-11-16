class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only: [:index, :about, :rules, :how_to_vote, :flow_chart,
                                            :next, :history, :entrypolicy, :terms, :policy]
  # トップページ
  def index
    @news = News.where("is_important = 'true'").order("date DESC").limit(5)

    @contestants = Contestant.approved.current_open_group.random(18)
  end

  # News
  def news
  end
end
