class NotificationFromAdminJob < ApplicationJob
  queue_as :default #どこのqueueを使用するか指定する。defaltしか使用しないならapplication_jobに書くのもあり

  def perform(msg) #これは絶対にか書かなくてはならないルール。Jobを実行した時にperform内の処理が実行される。msgを受け取れるように引数に渡す
    User.all.each do |user| #全員にメールを送るから繰り返し処理
      NotificationFromAdminMailer.notify(user, msg).deliver_later
    end
  end
end
