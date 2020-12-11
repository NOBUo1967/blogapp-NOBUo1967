class Apps::ApplicationController < ApplicationController
  before_action :authenticate_user!
  # このコントローラーを継承すればauthenticate_userが適用される。
end
