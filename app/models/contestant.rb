# 出場者モデル
class Contestant < User
  # デフォルトスコープの設定. Contestantのみに制限
  default_scope -> { where(user_type: Settings.user_type[:contestant]) }

  scope :random, ->(n) { where(id: pluck(:id).shuffle[0..n - 1]) }
  scope :approved, lambda {
    includes(:contestant_profile)
      .where(contestant_profiles: { status: ContestantProfile.statuses[:approved] })
  }
  scope :todays_preopen, -> { includes(:contestant_profile).where(contestant_profiles: { is_preopen: true }) }
  scope :nth_group, ->(n) { includes(:contestant_profile).where(contestant_profiles: { group_id: n }) }
  scope :current_open_group, lambda {
    includes(:contestant_profile)
      .where(contestant_profiles: { group_id: 1..Settings.current_open_group_id })
  }

  validates :agreement, acceptance: { message: "への同意が必要です" }

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
  end
end
