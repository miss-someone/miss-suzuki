class InterviewTopic < ActiveRecord::Base
  has_many  :interview_answers
  has_many  :users, through: :interview_answers

  validates :topic, presence: true

  # interview_answerの管理画面で、interview_topicのカラムを、番号でなくtopic名で表示するための記述
  # def to_s
  #   "#{topic}"
  # end
end
