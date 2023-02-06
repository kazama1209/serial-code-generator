class Admin::ApplicationController < ApplicationController
  layout "admin"

  before_action :admin_only

  private

  # ログイン済みの管理者以外はリダイレクト
  def admin_only
    return if current_admin

    redirect_to new_admin_session_path
  end
end
