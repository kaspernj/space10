class Api::V1::EventsController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:index, :show]

	def index
		render json: Event.published, status: 200
	end

	def show
		@event = Event.find(params[:id])
		respond_to do |format|
	    format.html { render 'events/show' }
	    format.json { render json: @event }
	  end
	end
end