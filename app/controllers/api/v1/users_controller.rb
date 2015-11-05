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
		if @user.update(user_params)
			@user
		else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end