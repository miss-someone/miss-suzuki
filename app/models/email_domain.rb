class EmailDomain < ActiveRecord::Base
  validates :domain, presence: true
  validates :is_forbidden, inclusion: { in: [true, false] }
  validates :is_notified, inclusion: { in: [true, false] }

  class << self
    def denied?(email)
      email_domain = email.sub(/.+@/, '')
      where(domain: email_domain, is_forbidden: true).exists?
    end

    def domains
      all.map(&:domain)
    end
  end
end
