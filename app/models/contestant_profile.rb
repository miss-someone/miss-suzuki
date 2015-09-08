class ContestantProfile < ActiveRecord::Base
  belongs_to :user

  # バリデーション
  validates :user_id, presence: true
  validates :group_id, presence: true, inclusion: { in: 1..3 }
  validates :name, presence: true
  validates :hurigana, presence: true
  validates :image_url, presence: true
  validates :age, presence: true
  validates :height, presence: true
  validates :come_from, presence: true
  validates :link_url, presence: true
  validates :comment, presence: true
  validates :thanks_comment, presence: true
  validates :link_url, presence: true
end
