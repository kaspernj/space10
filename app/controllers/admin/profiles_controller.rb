class Admin::ProfilesController < AdminController
	def new
		@profile = Profile.new		
	end

	def create
		@profile = Profile.new(profile_params)
		if @profile.save
			flash[:success] = 'Profile created'
			redirect_to edit_admin_profile_path(@profile)
		else
			render 'new'
		end
	end

	def index
		@profiles = Profile.all
	end

	def edit
		@profile = Profile.find(params[:id])
	end

	def update
		@profile = Profile.find(params[:id])
		if @profile.update(profile_params)
			flash[:success] = 'Profile updated'
			redirect_to edit_admin_profile_path(@profile)
		else
			render 'new'
		end
	end

	def destroy
		@profile = Profile.find(params[:id])
		@profile.destroy
		redirect_to admin_profiles_path, notice: 'Profile deleted'
	end

	private

	def profile_params
		type = params[:profile_type] || 'profile'
		params.require(type.underscore.to_sym).permit(:id, :type, :title, :location, :tag_tokens, :description, :published, image_attachment_attributes: [:id, :resource_type, :resource_id, :image, :image_cache, :_destroy])
	end
end