class Api::V1::ProfilesController < Api::V1::ApiController
	before_filter :authenticate_api_client, only: [:index, :show]

	def index		
		if params[:location].present?
      @profiles = Profile.published.where_tagged_with(params[:category]).near(params[:location]).paginate(page: params[:page], per_page: (params[:per_page].present? ? params[:per_page] : 5))
    else
      @profiles = Profile.published.where_tagged_with(params[:category]).paginate(page: params[:page], per_page: (params[:per_page].present? ? params[:per_page] : 5))
    end
	end

	def filter_options
		@categories = ProfileTag.all.pluck(:title)
		@locations = Profile.all.pluck(:location).uniq
	end

	def show
		@profile = Profile.published.find(params[:id])
		respond_to do |format|
	    format.html { render 'profiles/show' }
	    format.json { @profile }
	  end
	end
end