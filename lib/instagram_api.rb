class InstagramApi
	include HTTParty

	def hashtag_photos(hashtag)
		url = "https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}"
		Rails.cache.fetch(url, expires: 1.hour) do
			HTTParty.get(url)['meta']['code'] == 200 ? HTTParty.get(url)['data'] : nil rescue nil
		end
	end

	def popular_hashtag_photos(hashtag)
		url = "https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=#{ENV['INSTAGRAM_CLIENT_ID']}"
		Rails.cache.fetch(url, expires: 1.hour) do
			data = HTTParty.get(url)['meta']['code'] == 200 ? HTTParty.get(url)['data'] : nil rescue nil
			return data.sort_by{|k,v| k['likes']['count']}.reverse
		end
	end

	def user_photos(user)
		url = "https://api.instagram.com/v1/users/#{user}/media/recent?access_token=#{ENV['INSTAGRAM_ACCESS_TOKEN']}"
		Rails.cache.fetch(url, expires: 1.hour) do
			HTTParty.get(url)['meta']['code'] == 200 ? HTTParty.get(url)['data'] : nil rescue nil
		end
	end

end