class Api::V1::ProfilesController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:index, :show]

	def index
		@profiles = Profile.published
	end

	def show
		@profile = Profile.published.find(params[:id])
		respond_to do |format|
	    format.html { render 'profiles/show' }
	    format.json { @profile }
	  end
	end
end