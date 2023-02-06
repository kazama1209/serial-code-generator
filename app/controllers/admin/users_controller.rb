class Admin::UsersController < Admin::ApplicationController
  def edit; end

  def update
    if current_admin.update(admin_params)
      redirect_to admin_campaigns_path, success: "設定を変更しました"
    else
      render :edit
    end
  end

  private

  def admin_params
    params.require(:admin).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
