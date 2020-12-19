FactoryBot.define do
  factory :user do 
    email { Faker::Internet.email }
    password { 'password' }

    trait :with_profile do
      after :build do |user|
      # 上のインスタンスが作成された時にbuildされる。
        build(:profile, user: user)
        # userがbuildされるとprofileもbuildされる。
      end
    end
  end
end
