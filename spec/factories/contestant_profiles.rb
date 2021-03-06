FactoryGirl.define do
  factory :contestant_profile do
    user_id     1
    group_id    1
    name        "鈴木愛理"
    hurigana    "すずきあいり"
    profile_image "http://hogehoge"
    age         "20歳"
    height      "160cm"
    come_from   "新潟県"
    link_url    "http://facebook.com/hogehoge"
    comment     "頑張ります！"
    thanks_comment "ありがとう!"
    phone       "111-1111-1111"
    station     "渋谷駅"
    status      ContestantProfile.statuses[:approved]
    is_share_with_twitter_ok true
    is_interest_in_idol_group true
  end
end
