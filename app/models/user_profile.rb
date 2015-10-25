class UserProfile < ActiveRecord::Base
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :age
  belongs_to_active_hash :job

  alias_attribute :name, :nickname

  # 都道府県扱うgem
  include JpPrefecture
  jp_prefecture :prefecture_code, method_name: :pref

  validates :nickname, presence: true, length: { maximum: 15 }
  validates :sex, presence: true, inclusion: { in: [Settings.sex[:male], Settings.sex[:female]] }
  validates :age_id, presence: true, inclusion: { in: Age.first.id..Age.last.id }
  validates :prefecture_code, presence: true,
                              inclusion: { in: Prefecture.all.each_with_object([]) { |p, obj| obj << p.code } }
  validates :job_id, presence: true, inclusion: { in: Job.first.id..Job.last.id }
end
