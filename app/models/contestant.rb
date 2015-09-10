# 出場者モデル
class Contestant < User
  def profile=(p)
    self.contestant_profile = p
  end

  class << self
    # 出場者のユーザタイプを設定してUserモデルを返す
    def new
      contestant = super
      contestant.user_type = Settings.user_type[:contestant]
      contestant
    end
  end
end
