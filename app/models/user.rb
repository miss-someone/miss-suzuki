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

  # ユーザ作成時に，関連テーブルも同時に生成する
  accepts_nested_attributes_for :user_profile, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :contestant_profile, allow_destroy: true, reject_if: :all_blank

  # バリデーション
  validates :email, presence: true, uniqueness: true
  validates :user_type,
            presence: true,
            inclusion: [Settings.user_type[:normal], Settings.user_type[:contestant]]

  # ユーザタイプに応じてプロフィールを返す
  def profile
    if user_type == Settings.user_type[:contestant]
      contestant_profile
    else
      user_profile
    end
  end

  class << self
    # 出場者一覧を返す
    def contestants
      User.where(user_type: Settings.user_type[:contestant]).includes(:contestant_profile)
    end

    # 一般ユーザ一覧を返す
    def normal
      User.where(user_type: Settings.user_type[:normal]).includes(:user_profile)
    end
  end
end
