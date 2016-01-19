require 'parse_notification'

class Admin::RegistrationsController < AdminController

	def index
		@event = Event.find(params[:event_id])
		@registrations = @event.registrations
		respond_to do |format|
      format.html
      format.xls
    end
	end

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
			ParseNotification.new(user_id: @registration.user.id, data: {alert: "You have been confirmed for #{@registration.event.title}", type: 'Event', type_id: @registration.event.id}).send unless Rails.env.test?
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