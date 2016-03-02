class Idol < ActiveRecord::Base

  include ActiveModel::Model

  attr_accessor :name, :email, :age, :height, :hometown, :station, :school, :production

  validates :name, :presence => {:name => '名前を入力してください'}
  validates :email, :presence => {:email => 'メールアドレスを入力してください'}
  validates :age, :presence => {:age => '年齢を入力してください'}
  validates :height, :presence => {:height => '身長を入力してください'}
  validates :school, :presence => {:message => '学校名と学年を入力してください'}
  validates :hometown, :presence => {:hometown => '出身地を入力してください'}
  validates :station, :presence => {:station => '最寄駅を入力してください'}
  validates :production, :presence => {:production => 'プロダクションに所属しているかご回答ください'}
end
