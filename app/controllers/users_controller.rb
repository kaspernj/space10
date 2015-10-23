class UsersController < ApplicationController
	before_filter :only_new_users

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in(@user)
			redirect_to root_path, notice: "Signed up successfully"
		else
			render action: 'new'
		end
	end

private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def only_new_users
		if signed_in?
			redirect_to root_path
		end
	end
end
