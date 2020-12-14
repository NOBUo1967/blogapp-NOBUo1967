FactoryBot.define do
  factory :user do #userというfactoryを作成した
    email { Faker::Internet.email }
    password { 'password' }
    # user_modelにあるデータ
    # user_modelの設定を読み込んで、そこにemailとpasswordを入力したダミーデータを作成している。
  end
end