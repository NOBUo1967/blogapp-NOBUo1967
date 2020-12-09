namespace :notification do
  desc '利用者にメールを送付する' #rakeタスクの説明

  task send_emails_from_admin: :environment do #メールの送付などの設定の読み込み
    puts '初めてのrake task'
  end
end
