class ContestantProfile < ActiveRecord::Base
  belongs_to :user

  mount_uploader :profile_image, ContestantProfileImageUploader
  store_in_background :profile_image

  # バリデーション
  validates :group_id, presence: true, inclusion: { in: 1..3 }
  validates :name, presence: true, length: { maximum: 100 }
  validates :hurigana, presence: true, length: { maximum: 100 }
  validates :profile_image, presence: true
  validates :link_url, allow_blank: true, format: URI.regexp(%w(http https))
  validates :age, length: { maximum: 50 }
  validates :height, presence: true, length: { maximum: 50 }
  validates :come_from, presence: true, length: { maximum: 50 }
  validates :comment, presence: true, length: { maximum: 100 }
  validates :thanks_comment, presence: true, length: { maximum: 100 }
  validates :is_interest_in_idol_group, inclusion: { in: [true, false] }
  validates :is_share_with_twitter_ok, inclusion: { in: [true, false] }

  scope :approved, -> { where(status: ContestantProfile.statuses[:approved]) }
  scope :contestant_id, ->(n) { find_by(user_id: n) }
  scope :current_open_group, -> { where(group_id: 1..Settings.current_open_group_id) }

  # 承認ステータスのenum
  enum status: { pending_approval: 0, approved: 1, rejected: 2 }

  before_validation :prepare_validation
  before_save :prepare_save

  def prepare_validation
    # 現在の応募者を割り振るデフォルトグループの設定
    self.group_id = Settings.current_group_id if group_id.blank?
    self
  end

  def prepare_save
    # 年齢が未入力の場合はないしょで埋める
    self.age = 'ないしょ' if age.blank?
    # statusが存在しない場合は，approval_pendingにする
    self.status = ContestantProfile.statuses[:pending_approval] if status.blank?

    self.link_type = detect_link_type if !link_url.blank? && link_type.blank?

    self
  end

  private

  # link_urlのドメインからリンク種別を自動判別する
  # どれにも一致しない場合はwebに
  def detect_link_type
    require 'uri'
    domain = URI.parse(link_url).host.sub(/^www\./, '')
    case domain
    when 'facebook.com' then
      Settings.link_type[:facebook]
    when 'twitter.com' then
      Settings.link_type[:twitter]
    when 'mobile.twitter.com' then
      Settings.link_type[:twitter]
    when 'instagram.com' then
      Settings.link_type[:instagram]
    when 'ameblo.jp' then
      Settings.link_type[:blog]
    when 'youtube.com' then
      Settings.link_type[:movie]
    else
      Settings.link_type[:web]
    end
  end
end
