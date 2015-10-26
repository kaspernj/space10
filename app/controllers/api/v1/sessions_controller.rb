class Api::V1::SessionsController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:new]

	def new
		@user = User.find_by(email: params[:email])
		if @user && @user.authenticate(params[:password])
			render json: @user, serializer: Api::V1::UserSerializer, status: 200
		else @user
      render json: { errors: ["User not found or email/password combination was wrong"] }, status: 400
    end
	end

end