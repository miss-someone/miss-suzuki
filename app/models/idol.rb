class Idol < ActiveRecord::Base

  # include ActiveModel::Model

  # attr_accessor :name, :email, :age, :height, :hometown, :station, :school, :production, :date

  validates :name, :presence => {:name => "名前を入力してください"}
  validates :email, :presence => {:email => "メールアドレスを入力してください"}
  validates :age, :presence => {:age => "年齢を入力してください"}
  validates :height, :presence => {:height => "身長を入力してください"}
  validates :hometown, :presence => {:hometown => "出身地を入力してください"}
  validates :station, :presence => {:station => "最寄駅を入力してください"}
  validates :date, :presence => {:date => "説明会に参加できる日程を選択してください"}
end
