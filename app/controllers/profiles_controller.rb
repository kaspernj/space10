class ProfilesController < ApplicationController
	def index
		@profiles = Profile.published.paginate(:page => params[:page], :per_page => 8)
	end

	def show
		@profile = Profile.find(params[:id])
	end
end