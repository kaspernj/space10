class ProfilesController < ApplicationController
	def index
    if params[:location].present?
      @q = Profile.published.near(params[:location].split(",").map(&:to_f), 50).ransack(params[:q])
    else
      @q = Profile.published.ransack(params[:q])
    end
		@profiles = @q.result.includes(:tags).paginate(:page => params[:page], :per_page => 2)
	end

	def show
		@profile = Profile.published.find(params[:id])
    
		@q = Profile.published.ransack(params[:q])
    @profiles = @q.result.includes(:tags).paginate(:page => params[:page], :per_page => 2)
	end
end