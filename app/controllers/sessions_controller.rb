class SessionsController < ApplicationController
	before_filter :only_new_users, except: :destroy
	layout 'clean_application'

	def new
		respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		user = User.find_by(email: params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			sign_in(user)
			flash[:success] = "Logged in successfully"
			redirect_to root_path
		else
			flash.now.alert = "Invalid email or password"
			render 'new'
		end
	end

	def create_with_omniauth
		omniauth = request.env['omniauth.auth']
		user = Authentication.from_omniauth(omniauth).user
		if user.save
			user.personal_profile = PersonalProfile.from_omniauth(user, omniauth)
			sign_in(user)
			flash[:success] = "Logged in successfully"
			redirect_to root_path
		else
			flash[:danger] = "Could not authenticate"
			render :new
		end
	end

	def omniauth_failure
		flash[:danger] = "Authentication failed"
		redirect_to new_user_path
	end

	def destroy
		sign_out
		flash[:success] = "Logged out successfully"
		redirect_to root_path
	end

private
	
	def only_new_users
		if signed_in?
			redirect_to root_path
		end	
	end

end