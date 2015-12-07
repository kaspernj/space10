class Api::V1::SessionsController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:new]

	def create
		@user = User.find_by(email: params[:email])
		if @user && @user.authenticate(params[:password])
			@user
		else @user
      render json: { errors: ["User not found or email/password combination was wrong"] }, status: 400
    end
	end

  def create_with_omniauth
    omniauth = params
    @user = Authentication.from_omniauth(omniauth).user
    if @user.save
      @user.personal_profile = PersonalProfile.from_omniauth(@user, omniauth)
      @user
    else
      render json: { errors: ["User could not be authenticated."] }, status: 400
    end
  end

  def omniauth_failure
    render json: { errors: ["Authentication failure."] }, status: 400
  end
end