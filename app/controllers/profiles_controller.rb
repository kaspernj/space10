class ProfilesController < ApplicationController
	def index
		@profiles = Profile.published.paginate(:page => params[:page], :per_page => 8)
	end

	def show
		@profile = Profile.published.find(params[:id])
		@profiles = Profile.published.paginate(:page => params[:page], :per_page => 8)
	end
end