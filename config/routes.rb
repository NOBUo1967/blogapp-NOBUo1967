Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  #development環境であれば、/letter_openerというurlにアクセスすると、LetterOpenerWebの内容が見られるという設定。
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'
  resource :timeline, only: [:show]
  #timelineはuserにとって一つしかないためresourcesではなくresource

  resources :articles do
    resources :comments, only: [:index, :new, :create]

    resource :like, only: [:show, :create, :destroy]
    #getリクエストでいいねしているかどうかを判断するためshowが必要。
  end

  resources :accounts, only: [:show] do
  #アカウントの詳細pageを開いてfollow_buttonを出現させるため
    resources :follows, only: [:create]
    #入れ子にすることでaccounts/account_id/followsというurlができる
    resources :unfollows, only: [:create]
    #followsでdestroyしてもいいのでは？ => したくない
    #URLがきれい accounts/account_id/follows = url見るだけでfollowしていることがわかる。
    #followsをcreateはわかるがfollowsをdestroyはおかしい気がする
    #unfollowを作ると考える。 => 思想的なはなし
  end

  resource :profile, only: [:show, :edit, :update]
  resources :favorites, only: [:index]
end
