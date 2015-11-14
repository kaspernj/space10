class RegistrationsController < ApplicationController
	before_filter :find_event
	before_filter :only_signed_in_users
	before_filter :only_published_events, except: :show
	before_filter :only_current_events, except: :show
	before_filter :correct_user, only: [:show, :destroy]
	before_filter :only_once, only: [:new, :create]

	def show
		@registration = current_user.registrations.find_by(event: @event)
		unless @registration
			raise ActiveRecord::RecordNotFound
		end
	end

	def new
		current_user.registrations.new(event: @event)
		respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		@registration = current_user.registrations.new(event: @event)
		if @registration.save
			if @registration.event.fully_booked?
				UserMailer.waiting_registration(@registration.user.id, @registration.event.id).deliver_now
			else
				UserMailer.unconfirmed_registration(@registration.user.id, @registration.event.id).deliver_now
			end
			flash[:success] = "Seat requested"
			respond_to do |format|
	      format.html { redirect_to [@event, @registration] }
	      format.js
	    end
		else
			render 'new'
		end
	end

	def destroy
		
	end

private

	def find_event
		@event = Event.find(params[:event_id])
	end

	def only_signed_in_users
		if !signed_in?
			flash[:notice] = "Please sign up"
			redirect_to new_user_path
		end
	end

	def only_published_events
		if @event.status != :published
			flash[:danger] = "Event not found"
			redirect_to events_path
		end
	end

	def only_current_events
		if @event.historic?
			flash[:notice] = "Event has ended"
			redirect_to @event
		end
	end

	def correct_user
		if !current_user.registrations.find(params[:id]).present?
			redirect_to root_path
		end
	end

	def only_once
		@registration = current_user.registrations.find_by(event: @event)
		if @registration.present?
			flash[:notice] = "You have already requested a seat for this event"
			respond_to do |format|
	      format.html { redirect_to [@event, @registration] }
	      format.js
	    end
		end
	end

end