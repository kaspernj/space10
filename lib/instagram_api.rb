class InstagramApi
	include HTTParty

	def hashtag_photos(hashtag)
		url = "https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}"
		Rails.cache.fetch(url, :expires => 1.hour) do
			HTTParty.get(url)['data']
		end
	end

	def photos(user)
		user = '214647329'
		url = "https://api.instagram.com/v1/users/#{user}/media/recent?access_token=#{ENV['INSTAGRAM_ACCESS_TOKEN']}"
		Rails.cache.fetch(url, :expires => 1.hour) do
			HTTParty.get(url)['data']
		end
	end

end