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
  scope :nth_stage, lambda { |n|
    return includes(:contestant_profile).where(contestant_profiles: { is_in_2nd_stage: true }) if n == 2
    none
  }
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

    # トップページに表示するContestantを取得する
    # 条件は
    #   + マイページを作成していること
    #   + 承認済みであること
    #   + 現在の公開グループであること
    def toppage_contestants
      find_by_sql("
      SELECT * FROM users AS u
          WHERE user_type = #{Settings.user_type[:contestant]}
            AND EXISTS(
                  SELECT id FROM contestant_profiles AS cp
                    WHERE u.id = cp.user_id AND cp.status = 1 AND cp.group_id <= #{Settings.current_open_group_id}
                    )
            AND (
              EXISTS(
                SELECT id FROM contestant_images AS c WHERE c.user_id = u.id AND c.is_pending = FALSE
              )
              OR
              EXISTS(
                SELECT id FROM interview_answers AS i WHERE i.user_id = u.id AND i.is_pending = FALSE
              )
            )"
                 )
    end
  end
end
