class Vote < ActiveRecord::Base
  belongs_to :voter
  belongs_to :contestant

  validates :contestant_id, presence: true
  validates :group_id,      presence: true
end
