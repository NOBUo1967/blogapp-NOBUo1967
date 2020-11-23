class RelationshipMailer < ApplicationMailer
  def new_follower(user, follower)
    @user = user
    @follower = follower
    mail to: user.email, subject: '【お知らせ】フォローされました'
  end
end

# 使い方
# RelationshipMailer.new_follower(User.first)