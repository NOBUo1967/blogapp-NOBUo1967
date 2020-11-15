class TimelinesController < ApplicationController
  before_action :authenticate_user!

  def show
    user_ids = current_user.followings.pluck(:id)
    # pluck = followingsの取得できたrecodeのidをとれる
    # ex) User1 のfollowingがuser2,user3,user4の場合 => [2,3,4]
    @articles = Article.where(user_id: user_ids)
    #user_idがuser_idsに含まれているやつを探してくればいい。
    #puclkでArrayをわたすと、or検索で値を渡してくれる。
  end
end
