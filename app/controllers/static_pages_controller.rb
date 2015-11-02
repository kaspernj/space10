class StaticPagesController < ApplicationController

	def home
		@posts = Post.published.limit(3)
		@events = Event.published.current_or_future.limit(2)
		@profiles = Profile.published.limit(4)
		@current_lab = Lab.current_or_next
		@instagram_photos = InstagramApi.new.user_photos('214647329') unless Rails.env.test?
	end

end