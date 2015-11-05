class Admin::RegistrationsController < AdminController

	def update
		@registration = Registration.find(params[:id])
		if @registration.update(registration_params)
			flash[:success] = "Registration updated"
		else
			flash[:danger] = "Registration could not be updated"
		end
		redirect_to admin_event_path(@registration.event)
	end

	def confirm_registration
		@registration = Registration.find(params[:id])
		@registration.update_attributes(confirmed: true)
		if @registration.save
			UserMailer.confirm_registration(@registration.user.id, @registration.event.id).deliver_now
			flash[:success] = "Registration confirmed"
		else
			flash[:danger] = "Registration could not be updated"
		end
		redirect_to admin_event_path(@registration.event)
	end

private

	def registration_params
		params.require(:registration).permit(:id, :event_id, :user_id, :confirmed)
	end
end