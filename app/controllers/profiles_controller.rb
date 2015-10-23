class ProfilesController < ApplicationController
	def index
		@profiles = Profile.published
	end

	def show
		@profile = Profile.find(params[:id])
	end
end