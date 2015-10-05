class Api::V1::EventsController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:index, :show]

	def index
		render json: Event.published, status: 200
	end

	def show
		render json: Event.find(params[:id]), status: 200
	end
end