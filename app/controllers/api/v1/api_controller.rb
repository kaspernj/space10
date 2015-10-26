class Api::V1::ApiController < ApplicationController
	protect_from_forgery with: :null_session

  before_action :destroy_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found


  def default_serializer_options
	  {root: false}
	end

	private

  def not_found(error)
    render :json => {:error => error.message}, :status => :not_found
  end

	def destroy_session
    request.session_options[:skip] = true
  end

	def authenticate_api_client
		authenticate_or_request_with_http_basic do |username, password|
			username == ENV['API_USER'] && password == ENV['API_SECRET']
		end
	end

	def authenticate_api_user
    authenticate_or_request_with_http_token do |token, options|     
      @user = User.find_by(auth_token: token)
    end
  end
end