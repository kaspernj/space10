class Admin::RegistrationsController < AdminController

	def update
		@registration = Registration.find(params[:id])
		if @registration.update(registration_params)
			flash[:success] = "Registration updated"
			redirect_to admin_event_path(@registration.event)
		else
			redirect_to admin_event_path(@registration.event)
		end
	end

	def confirm_registration
		@registration = Registration.find(params[:id])
		@registration.confirmed? ? @registration.update_attributes(confirmed: false) : @registration.update_attributes(confirmed: true)
		@registration.save ? flash[:success] = "Registration updated" : flash[:danger] = "Registration could not be updated"
		redirect_to admin_event_path(@registration.event)
	end

private

	def registration_params
		params.require(:registration).permit(:id, :event_id, :user_id, :confirmed)
	end
end