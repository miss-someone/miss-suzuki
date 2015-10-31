class ContestantImage < ActiveRecord::Base
  belongs_to :user
  mount_uploader :profile_image, ContestantProfileImageUploader
  validates :profile_image, presence: true
end
