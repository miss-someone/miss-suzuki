# 出場者とタグの多対多関連テーブル
class ContestantTagContestant < ActiveRecord::Base
  belongs_to :contestant_tag
  belongs_to :contestant_user, :class_name => "User", :foreign_key => :id
end
