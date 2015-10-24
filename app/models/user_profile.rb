class UserProfile < ActiveRecord::Base
  belongs_to :user

  alias_attribute :name, :nickname

  # 都道府県扱うgem
  include JpPrefecture
  jp_prefecture :prefecture_code, method_name: :pref
end
