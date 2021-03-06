class StaticPagesController < ApplicationController

	def home
		@posts = Post.published.limit(3)
		@events = Event.published.current_or_future.limit(2)
    @past_events = Event.published.historic.limit(2)
		@profiles = Profile.published.featured.limit(4)
		@current_lab = Lab.current_or_next || Lab.historic.first
		@instagram_photos = InstagramApi.new.user_photos('2179243523') unless Rails.env.test?
	end

  def about
    prepare_meta_tags(title: 'About')
  end

end