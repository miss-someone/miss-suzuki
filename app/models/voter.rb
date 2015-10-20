# 投票者モデル
class Voter < User
  # デフォルトスコープの設定．normalユーザのみに制限
  default_scope -> { where(user_type: Settings.user_type[:normal]) }

  validate :check_duplicate_email_with_alias
  validate :check_using_plus_alias

  # Googleの+を用いたエイリアスを弾くため，+が含まれていないかチェック
  # 独自エラーメッセージを出すために，validateでは行わない
  def check_using_plus_alias()
    if email.present? and email.include?('+')
      errors.add(:email, "メールアドレスに「+」を含めることは出来ません")
    end
  end

  # Googleの.を用いたエイリアスで，重複するメールアドレスが存在しないかチェックする
  def check_duplicate_email_with_alias()
    return if email.nil?
    striped_email = email.gsub('.', '')
    if Voter.count_by_sql(["SELECT COUNT(id) FROM users WHERE replace(email, '.', '') = ?", striped_email]) > 0
      errors.add(:email, "既に登録されているメールアドレスです．")
    end
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
