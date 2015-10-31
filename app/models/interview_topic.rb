class InterviewTopic < ActiveRecord::Base
  has_many  :interview_answers
  has_many  :users, through: :interview_answers

  validates :topic, presence: true
end
