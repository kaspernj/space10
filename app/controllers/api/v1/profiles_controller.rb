class Api::V1::ProfilesController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:index, :show]

	def index
		@profiles = Profile.published.paginate(page: params[:page], per_page: (params[:per_page].present? ? params[:per_page] : 5))
	end

	def show
		@profile = Profile.published.find(params[:id])
		respond_to do |format|
	    format.html { render 'profiles/show' }
	    format.json { @profile }
	  end
	end
end