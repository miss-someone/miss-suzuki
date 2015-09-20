class ContestantProfile < ActiveRecord::Base
  belongs_to :user

  mount_uploader :profile_image, ContestantProfileImageUploader

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
  validates :is_interest_in_idol_group, presence: true
  validates :is_share_with_twitter_ok, presence: true

  before_save :prepare_validation

  def prepare_validation
    if age.blank?
      # 年齢が未入力の場合はないしょで埋める
      self.age = 'ないしょ'
    end
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
