class InterviewAnswer < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :interview_topic

  validates :user, presence: true
  validates :interview_topic, presence: true
  validates :answer, presence: true
  validates :is_pending, inclusion: { in: [true, false] }
end
