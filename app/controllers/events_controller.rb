class EventsController < ApplicationController
	def index
		@events = Event.published
	end

	def show
		@event = Event.published.find(params[:id])
	end
end