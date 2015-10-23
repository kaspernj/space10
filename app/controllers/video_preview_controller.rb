class VideoPreviewController < ApplicationController
	def create
		require 'oembed'
		OEmbed::Providers.register(OEmbed::Providers::Youtube, OEmbed::Providers::Vimeo)
		resource = OEmbed::Providers.get(params[:video_url])
		if resource.provider_name.downcase == 'youtube'
			resource.fields['video_id'] = params[:video_url].match(/(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/ ]{11})/i)[1]
		end
		render json: resource.fields, status: 200
	end
end