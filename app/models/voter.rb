# 投票者モデル
class Voter < User
  # デフォルトスコープの設定．normalユーザのみに制限
  default_scope -> { where(user_type: Settings.user_type[:normal]) }

  validate :prepare_validation

  def prepare_validation()
    check_using_plus_alias and check_duplicate_email_with_alias
  end

  # Googleの+を用いたエイリアスを弾くため，+が含まれていないかチェック
  # 独自エラーメッセージを出すために，validateでは行わない
  def check_using_plus_alias()
    if email.present? and email.include?('+')
      errors.add(:email, "メールアドレスに「+」を含めることは出来ません")
    end
  end

  # Googleの.を用いたエイリアスで，重複するメールアドレスが存在しないかチェックする
  def check_duplicate_email_with_alias()
    true
  end

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
