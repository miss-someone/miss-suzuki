class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # 出場者の場合のプロフィール
  has_one :contestant_profile
  # 投票者の場合にプロフィール
  has_one :user_profile
  # タグ付けのためのリレーション
  has_many :contestant_tag_contestants
  # 出場者に関連付けられているタグ一覧
  has_many :contestant_tags

  def profile
    if user_type == Settings.user_type[:contestant]
      contestant_profile
    else
      user_profile
    end
  end
end
