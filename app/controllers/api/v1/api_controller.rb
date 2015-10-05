class Api::V1::ApiController < ApplicationController
	protect_from_forgery with: :null_session

  before_action :destroy_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: { errors: ["Not found"] }, status: 404
  end

  def default_serializer_options
	  {root: false}
	end

	private

	def destroy_session
    request.session_options[:skip] = true
  end

	def authenticate_api_client
		authenticate_or_request_with_http_basic do |username, password|
			username == "ios_app" && password == "secret123"
		end
	end

	def authenticate_api_user
    authenticate_or_request_with_http_token do |token, options|     
      @user = User.find_by(auth_token: token)
    end
  end
end