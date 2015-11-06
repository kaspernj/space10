class ProfilesController < ApplicationController
	def index
    @q = Profile.published.ransack(params[:q])
		@profiles = @q.result.includes(:tags).paginate(:page => params[:page], :per_page => 2)
	end

	def show
		@profile = Profile.published.find(params[:id])
		@profiles = Profile.published.paginate(:page => params[:page], :per_page => 8)
	end
end