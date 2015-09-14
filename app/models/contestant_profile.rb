class ContestantProfile < ActiveRecord::Base
  belongs_to :user

  mount_uploader :profile_image, ContestantProfileImageUploader

  # バリデーション
  validates :group_id, presence: true, inclusion: { in: 1..3 }
  validates :name, presence: true, length: { maximum: 100 }
  validates :hurigana, presence: true, length: { maximum: 100 }
  validates :profile_image, presence: true
  validates :link_url, allow_blank: true, format: URI.regexp(%w(http https))
  validates :age, presence: true, length: { maximum: 50 }
  validates :height, presence: true, length: { maximum: 50 }
  validates :come_from, presence: true, length: { maximum: 50 }
  validates :comment, presence: true, length: { maximum: 100 }
  validates :thanks_comment, presence: true, length: { maximum: 100 }
  validates :is_interest_in_idol_group, presence: true
  validates :is_share_with_twitter_ok, presence: true
end
