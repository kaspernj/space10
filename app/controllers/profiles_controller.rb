class ProfilesController < ApplicationController
	def index
    if params[:location].present?
      @q = Profile.published.near(params[:location].split(",").map(&:to_f), 50).ransack(params[:q])
    else
      @q = Profile.published.ransack(params[:q])
    end
		@profiles = @q.result.includes(:tags).paginate(page: params[:page], per_page: 12)

    prepare_meta_tags(title: "Community")

    respond_to do |format|
      format.html
      format.js
    end
	end

	def show
		@profile = Profile.published.find(params[:id])
    
		@q = Profile.published.ransack(params[:q])
    @profiles = @q.result.includes(:tags).paginate(page: params[:page], per_page: 12)

    prepare_meta_tags(title: @profile.title,
                      description: @profile.description,
                      image: @profile.image_url(:large),
                      type: 'profile',
                      twitter_card: "summary_large_image")

    respond_to do |format|
      format.html
      format.js
    end
	end
end