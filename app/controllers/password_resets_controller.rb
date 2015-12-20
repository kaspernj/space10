class PasswordResetsController < ApplicationController
  layout 'clean_application'

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    user.send_password_reset if user
    redirect_to root_url, notice: "Email sent with reset instructions"
  end

  def edit
    @user = User.find_by!(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by!(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to root_url, alert: "Password reset link has expired. Please request a new one."
    elsif @user.update_attributes(user_params)
      redirect_to login_url, notice: "Your password has been reset!"
    else
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end