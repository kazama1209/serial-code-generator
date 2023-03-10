# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController

  private

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(_resource)
    admin_campaigns_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(_resource)
    new_admin_session_path
  end
end
