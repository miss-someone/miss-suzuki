class InterviewTopic < ActiveRecord::Base
  has_many  :interview_answers

  validates :topic, presence: true
end
