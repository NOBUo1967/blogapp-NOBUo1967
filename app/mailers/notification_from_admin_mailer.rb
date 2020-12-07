class NotificationFromAdminMailer < ApplicationMailer
  def notify(user, msg)
    @msg = msg #msgを引数にしてmsgを渡せばadminがuserにメッセージを送れるようにする。
    mail to: user.email, subject: 'お知らせ'
  end
end
