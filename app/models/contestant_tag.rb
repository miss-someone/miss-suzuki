class ContestantTag < ActiveRecord::Base
  # タグ付けのためのリレーション
  has_many :contestant_tag_contestants
  # タグに関連付けられたユーザ一覧
  has_many :contestant_users, class_name: "User", through: :contestant_tag_contestants
end
