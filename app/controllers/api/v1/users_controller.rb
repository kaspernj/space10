class Api::V1::UsersController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:create]
	before_filter :authenticate_api_user, only: [:show, :update]

	def create
		user = User.create!(user_params)
		if user.save
			render json: user.to_json, status: 201
		else
      render json: { errors: user.errors.full_messages }, status: 422
    end
	end

	def show
		render json: @user, status: 200
	end

	def update
		if @user.update(user_params)
			render json: @user, status: 200
		else
      render json: { errors: user.errors.full_messages }, status: 422
    end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end