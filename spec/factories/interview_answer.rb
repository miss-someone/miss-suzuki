FactoryGirl.define do
  factory :interview_answer do
    interview_topic_id  1
    user_id             1
    answer              "たけのうちゆたか"
    is_pending          false
  end
end
