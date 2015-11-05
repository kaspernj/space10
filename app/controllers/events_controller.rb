class EventsController < ApplicationController
	def index
		@events = Event.published.current_or_future
		@previous_events = Event.published.historic
	end

	def show
		@event = Event.published.find(params[:id])
	end
end