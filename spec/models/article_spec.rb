require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user)  do
    User.create!({
      email: 'test@example.com',
      password: 'password'
    })
  end
    # userはどちらのcontextでも使用するので上に書いておく

  context 'タイトルと内容が入力されている場合' do
    let!(:article) do
      user.articles.build({
        title: Faker::Lorem.characters(number: 10),
        content: Faker::Lorem.characters(number: 300)
      })
    end

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end


  context 'タイトルの文字が一文字の場合' do
    let!(:article) do
      user.articles.create({
        # createを実行しないとエラーメッセージが取得できない。エラーメッセージが出るのはsaveやcreateのタイミングのみ。
        title: Faker::Lorem.characters(number: 1),
        content: Faker::Lorem.characters(number: 300)
      })
    end

    it '記事を保存できない' do
      expect(article.errors.messages[:title][0]).to eq('は2文字以上で入力してください')
      # errors = flash復習 messagesで取得できる。
      # title = タイトルに関するエラーメッセージが取得できる。配列で渡ってくるので0番目を取る
      # エラーメッセージとイコールであればオッケー。メッセージ内容は調べる。
    end
  end
end
