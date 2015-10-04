# 出場者モデル
class Contestant < User
  # デフォルトスコープの設定. Contestantのみに制限
  default_scope -> { where(user_type: Settings.user_type[:contestant]) }

  scope :random, ->(n){ self.where(id: self.pluck(:id).shuffle[0..n-1]) }

  def profile=(p)
    self.contestant_profile = p
  end

  class << self
    # 出場者のユーザタイプを設定してUserモデルを返す
    def new(params = nil)
      contestant = nil
      if params.nil?
        contestant = super
      else
        contestant = super(params)
      end
      contestant.user_type = Settings.user_type[:contestant]
      contestant
    end

    # 今日のプレオープンの候補者を取得
    def todays_preopen
      # TODO: joins includeどっちにするか考える
      joins(:contestant_profile).where(contestant_profiles: { is_preopen: true })
    end
  end
end
