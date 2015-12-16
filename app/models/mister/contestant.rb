# 出場者モデル(Mister)
class Mister::Contestant < Contestant
  # デフォルトスコープの設定. 男性のContestantのみに制限
  default_scope lambda {
    includes(:contestant_profile)
      .where(user_type: Settings.user_type[:contestant],
             contestant_profiles: { sex: 'male' })
  }
end
