class Api::ApplicationController < ApplicationController
  # Api:: <= ネームスペース。ディレクトリ内のクラスには「ディレクトリ名::」とつけるのが慣例。
  # ネームスペースをつけることで、もともとあるApplication_controllerとは別物というアピール。
  # ディレクトリ内に更にディレクトリを作った場合は「親ディレクトリ名::子ディレクトリ名::〇〇Contorller」となる。
  
  # Api::ApplicationControllerを作成した意味。
  # Apiでまとめている。Api特有の処理を書く可能性がある。
  # controllerごとに処理を書くのは面倒だが、ApplicationControllerに書いてしまうとApiと関係がないcontrollerにも継承されてしまう。
  # Apiだけに共通化させたい場合にApi::ApplicationControllerに書けば良い。
end
