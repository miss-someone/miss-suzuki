class StaticPagesController < ApplicationController
  skip_before_filter :require_login, only: [:index, :about, :rules, :how_to_vote, :flow_chart,
                                            :next, :history, :entrypolicy, :terms, :policy]
  # トップページ
  def index
    @news = News.where("is_important = 'true'").order("date DESC").limit(5)

    # トップページに表示する18人を選択
    # トップページの表示は遅くしたくないので，キャッシュを行う
    # 更新は30分毎
    @contestants = Rails.cache.fetch('toppage_contestants', expires_in: 5.seconds) do
      contestants = Contestant.toppage_contestants.sample(18)
      ActiveRecord::Associations::Preloader.new.preload(contestants, :contestant_profile)
      contestants
    end
  end

  # News
  def news
  end
end
