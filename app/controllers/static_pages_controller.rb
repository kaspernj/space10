class StaticPagesController < ApplicationController

	def home
		@posts = Post.published.limit(3)
		@events = Event.published.future.limit(2)
		@profiles = Profile.published.limit(4)
		@current_lab = Lab.first
		@instagram_photos = InstagramApi.new.user_photos('214647329')
	end

end