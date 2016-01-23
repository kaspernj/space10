class Api::V1::User::RegistrationsController < Api::V1::ApiController
	before_filter :authenticate_api_user

	def index
		@registrations = @user.registrations
	end

	def show
		@registration = @user.registrations.find(params[:id])
	end

	def create
		@registration = @user.registrations.find_or_initialize_by(event_id: registration_params['event_id'])
		if @registration.save
			@registration
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