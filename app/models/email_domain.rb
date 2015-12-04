class EmailDomain < ActiveRecord::Base
  validates :domain, presence: true
  validates :is_forbidden, inclusion: { in: [true, false] }
  validates :is_notified, inclusion: { in: [true, false] }
end
