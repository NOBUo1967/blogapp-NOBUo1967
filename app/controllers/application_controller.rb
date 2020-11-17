class ApplicationController < ActionController::Base
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    # ActiveDecoratorのDecorateとインスタンスを実行するとインスタンス自体がDecoratorを使える。
    # super = deviseが定義しているcurrent_userが存在する場合はcurrent_userをdecorateしてcurrent_userを返す。
    super
  end
end
