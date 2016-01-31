class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only: [:index, :final , :about, :rules, :how_to_vote, :flow_chart,
                                            :next, :history, :entrypolicy, :terms, :policy, :help]
  # トップページ
  def index
    @news = News.where("is_important = 'true'").order("date DESC").limit(5)

    # トップページに表示する18人を選択
    # トップページの表示は遅くしたくないので，キャッシュを行う
    # 更新は30分毎
    @contestants = Rails.cache.fetch('toppage_contestants', expires_in: 5.seconds) do
      Contestant.approved.semifinal
    end
  end

  # News
  def news
  end
end
