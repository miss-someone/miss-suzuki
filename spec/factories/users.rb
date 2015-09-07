FactoryGirl.define do
  factory :user do
    email "suzuki@miss-someone.com"
    password "hogehoge"
    user_type Settings.user_type[:normal]

    factory :contestant do
      email "contestant@miss-someone.com"
      user_type Settings.user_type[:contestant]
    end
  end
end
