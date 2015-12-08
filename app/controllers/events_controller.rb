class EventsController < ApplicationController
	def index
		@events = Event.published.current_or_future
		@previous_events = Event.published.historic
    prepare_meta_tags(title: "Program")
	end

	def show
		@event = Event.published.find(params[:id])
    prepare_meta_tags(title: @event.title,
                      description: @event.excerpt,
                      image: @event.featured_image_url(:large),
                      type: 'event',
                      event: {start_time: @event.starts_at.in_time_zone('Copenhagen').iso8601},
                      twitter: {card: "summary_large_image"},
                      )
	end
end