class Api::V1::EventsController < Api::V1::ApiController
	before_filter :authenticate_api_client, :unless => :get_user?
	before_filter :authenticate_api_user, :if => :get_user?
	before_filter :load_events

	def index
		@events = @events.published.paginate(page: params[:page], per_page: (params[:per_page].present? ? params[:per_page] : 5))
	end

	def future
		@events = @events.published.current_or_future.paginate(page: params[:page], per_page: (params[:per_page].present? ? params[:per_page] : 5))
	end

	def historic
		@events = @events.published.historic.paginate(page: params[:page], per_page: (params[:per_page].present? ? params[:per_page] : 5))
	end

	def show
		@event = @events.published.find(params[:id])
		respond_to do |format|
	    format.html { render 'events/show' }
	    format.json { @event }
	  end
	end

private

	def load_events
		lab = Lab.find(params[:lab_id]) if params[:lab_id]
		@events = lab ? lab.events : Event.all
	end

	def get_user?
		request.headers["HTTP_AUTHORIZATION"].include?("Token")
	end
end