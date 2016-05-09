class UsersController < ApplicationController
	before_filter :only_new_users, only: [:new, :create]
	layout 'clean_application', only: :new

	def new
		@user = User.new
		respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in(@user)
			flash[:notice] = "Signed up successfully"
			redirect_back_or root_path
		else
			render action: 'new', layout: 'clean_application'
		end
	end

	def show
		@user = User.find(params[:id])
		respond_to do |format|
      format.html
      format.js
    end
	end

	def edit
		@user = User.find(params[:id])
		@user.build_personal_profile if @user.personal_profile.blank?
		respond_to do |format|
      format.html
      format.js
    end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			respond_to do |format|
	      format.html { redirect_to edit_user_path(@user) }
	      format.js
	    end
	  else
	  	respond_to do |format|
	      format.html { render :edit }
	      format.js
	    end
	  end
	end

private

	def user_params
		params.require(:user).permit(:name, :email, :birthday, :gender, :password, :password_confirmation, personal_profile_attributes: [:id, :website, :location, :description, :tagline, :tag_tokens, :image, :image_cache])
	end

	def only_new_users
		if signed_in?
			redirect_to root_path
		end
	end
end
