class Vote < ActiveRecord::Base
  belongs_to :voter
  belongs_to :contestant

  validates :contestant_id, presence: true
  validates :group_id,      presence: true

  scope :today, -> { where(created_at: (Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)) }

  class << self
    def todays_vote_count_with_no_login(ip_address, cookie_token, group_id)
      today.where(group_id: group_id).where(['ip_address = ? or cookie_token = ?', ip_address, cookie_token]).count
    end

    def todays_vote_count_with_login(voter_id, group_id)
      today.where(voter_id: voter_id, group_id: group_id).count
    end
  end
end
