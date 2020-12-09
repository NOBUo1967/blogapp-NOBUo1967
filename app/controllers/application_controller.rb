class ApplicationController < ActionController::Base
  before_action :set_locale
    # before_actionとするとactionが実行される前にset_localeが実行される。
    # すべてのコントローラーはapplication_controllerを継承している。
    # =>すべてのactionにおいてset_localeが実行される。すべてのページで設定言語が設定されるようになる。


  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    # ActiveDecoratorのDecorateとインスタンスを実行するとインスタンス自体がDecoratorを使える。
    # super = deviseが定義しているcurrent_userが存在する場合はcurrent_userをdecorateしてcurrent_userを返す。
    super
  end

  def default_url_options
    # before_actionにする必要なし。必ずdefaultで実行されるようになっている。
    { locale: I18n.locale }
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    # 設定言語を変更する処理を書く。
    # なければdefault_localeを使用するようにする。
  end 
end
