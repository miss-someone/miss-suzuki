FactoryGirl.define do
  factory :voter do
    email "suzuki@miss-someone.com"
    password "hogehoge"
    user_type Settings.user_type[:normal]
    activation_state "active"

    factory :voter2 do
      email "suzuki2@miss-someone.com"
      password "hogehoge"
    end

    factory :dot_alias1 do
      email "mi.ss-su.zu.ki@gmail.com"
    end
    factory :dot_alias2 do
      email "m.iss-s.uzu.ki@gmail.com"
    end
  end
end
