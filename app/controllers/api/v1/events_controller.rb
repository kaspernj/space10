class Api::V1::EventsController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:index, :show]

	def index
		@events = Event.published.paginate(page: params[:page], per_page: (params[:per_page].present? ? params[:per_page] : 5))
	end

	def show
		@event = Event.published.find(params[:id])
		respond_to do |format|
	    format.html { render 'events/show' }
	    format.json { @event }
	  end
	end
end