class Vote < ActiveRecord::Base
  belongs_to :voter
  belongs_to :contestant

  validates :contestant_id, presence: true
  validates :group_id,      presence: true

  scope :today, -> { where(['? =< updated_at and updated_at < ?', Date.today, Date.tomorrow]) }

  class << self
    def todays_vote_count_with_no_login(ip_address, cookie_token)
      today.where(['ip_address = ? or cookie_token = ?', request.remote_ip, vote_token]).count
    end

    def todays_vote_count_with_login(voter_id)
      today.where(voter_id: voter_id).count
    end
  end
end
