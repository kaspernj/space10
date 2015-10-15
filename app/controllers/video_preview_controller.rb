class VideoPreviewController < ApplicationController
	def create
		require 'oembed'
		OEmbed::Providers.register(OEmbed::Providers::Youtube, OEmbed::Providers::Vimeo)
		resource = OEmbed::Providers.get(params[:video_url])
		render json: resource.fields, status: 200
	end
end