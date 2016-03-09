class Idol < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :age, presence: true
  validates :height, presence: true
  validates :hometown, presence: true
  validates :station, presence: true
  validates :date, presence: true
end
