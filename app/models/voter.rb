# 投票者モデル
class Voter < User
  # デフォルトスコープの設定．normalユーザのみに制限
  default_scope -> { where(user_type: Settings.user_type[:normal]) }

  def profile=(p)
    self.user_profile = p
  end

  class << self
    # 通常のユーザタイプを設定してUserモデルを返す
    def new(params = nil)
      voter = params.nil? ? super : super(params)
      voter.user_type = Settings.user_type[:normal]
      voter
    end
  end
end
