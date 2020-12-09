namespace :notification do
  desc '利用者にメールを送付する' #rakeタスクの説明

  task :send_emails_from_admin, ['msg'] => :environment do |task, args|
    # args = arguments(引数) これにmsgの内容が渡ってくる。
    msg = args['msg']
    if msg.present?
      NotificationFromAdminJob.perform_later(msg)
    else #失敗した時に遅れたのか遅れてないのかわからないためわかるようにする。
      puts '送信できませんでした。メッセージを入力してください。ex.rails notification:send_emails_from_admin\[こんにちは\]'
      #自分でコマンドを作る時は使う人がどうしたらいいかわかるように、エラーメッセージを書いてあげる。
    end
  end
end
