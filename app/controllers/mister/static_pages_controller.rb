class Mister::StaticPagesController < Mister::ApplicationController
  skip_before_filter :require_login, only: [:index, :about, :rules, :how_to_vote, :flow_chart,
                                            :next, :history, :entrypolicy, :terms, :policy, :help]
  def index
    @news = News.where("is_important = 'true'").order("date DESC").limit(5)
  end
end
