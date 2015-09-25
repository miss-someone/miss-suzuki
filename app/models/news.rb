class News < ActiveRecord::Base
  validates :date, presence: true
  validates :content, presence: true
end
