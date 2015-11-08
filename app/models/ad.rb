# encoding: utf-8

class Ad < ActiveRecord::Base
  mount_uploader :image, AdsUploader
  store_in_background :image

  validates :name, presence: true
  validates :is_active, presence: true

  scope :active, -> { where(is_active: true) }
end
