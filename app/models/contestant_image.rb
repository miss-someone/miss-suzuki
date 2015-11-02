class ContestantImage < ActiveRecord::Base
  belongs_to :user
  mount_uploader :profile_image, ContestantProfileImageUploader
  store_in_background :profile_image

  validates :profile_image, presence: true
  validates :is_pending, inclusion: { in: [true, false] }

  scope :approved, -> { where(is_pending: false) }
end
