class Api::V1::EventsController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:index, :show]

	def index
		@events = Event.published
	end

	def show
		@event = Event.published.find(params[:id])
		respond_to do |format|
	    format.html { render 'events/show' }
	    format.json { @event }
	  end
	end
end