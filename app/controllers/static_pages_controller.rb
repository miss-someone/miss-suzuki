class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only: [:index, :about, :rules, :how_to_vote, :flow_chart,
                                            :next, :history, :entrypolicy, :terms, :policy]
  # トップページ
  def index
    @news = News.where("is_important = 'true'").order("date DESC").limit(5)

    @contestants = Contestant.approved.nth_group(1).random(3)
  end

  # News
  def news
  end
end
