class InstagramApi
	include HTTParty

	def photos(hashtag)
		url = "https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}"
		Rails.cache.fetch(url, :expires => 1.hour) do
			HTTParty.get(url)['data']
		end
	end

end