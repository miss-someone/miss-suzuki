class News < ActiveRecord::Base
  validates :content, presence: true
end
