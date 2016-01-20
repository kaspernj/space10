class Api::V1::UsersController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:create]
	before_filter :authenticate_api_user, only: [:show, :update]

	def create
		@user = User.new(user_params)
		if @user.save
			@user
		else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
	end

	def show
		@user
	end

	def update
		new_params = user_params.deep_merge(personal_profile_attributes: {id: @user.personal_profile.id})
		if @user.update(new_params)
			@user.reload
		else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :birthday, :gender, :password, :password_confirmation, personal_profile_attributes: [:id, :website, :location, :description, :tagline, :tag_tokens, :image, :image_cache])
	end
end