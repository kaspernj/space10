class Api::V1::User::RegistrationsController < Api::V1::ApiController
	before_filter :authenticate_api_user

	def index
		render json: @user.registrations, status: 200
	end

	def show
		render json: @user.registrations.find(params[:id]), status: 200
	end

	def create
		@registration = Registration.new(registration_params)
		if @registration.save
			render json: @registration, status: 201
		else
			render json: { errors: @registration.errors.full_messages }, status: 422
		end
	end

	def destroy
		registration = Registration.find(params[:id])
		registration.destroy
		render json: { message: "Registration destroyed" }, status: 200
	end

	private

	def registration_params
		params.require(:registration).permit(:id, :user_id, :event_id)
	end
end