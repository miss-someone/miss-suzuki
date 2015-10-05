class UserProfile < ActiveRecord::Base
  belongs_to :user

  alias_attribute :name, :nickname

end
