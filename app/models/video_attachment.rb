# == Schema Information
#
# Table name: video_attachments
#
#  id            :integer          not null, primary key
#  title         :string
#  description   :string
#  featured      :boolean
#  provider      :string
#  video_id      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  video_url     :string
#  resource_type :string
#  resource_id   :integer
#

class VideoAttachment < ActiveRecord::Base
	# validate :parse_url, if: :validate_video_url?


	# private

	# def parse_url
	# 	require 'oembed'
	# 	OEmbed::Providers.register(OEmbed::Providers::Youtube, OEmbed::Providers::Vimeo)
	# 	resource = OEmbed::Providers.get(self.video_url) rescue nil
	# 	if resource
	# 		self.provider = resource.provider_name
	# 		self.video_id = resource.video_id
	# 	else
	# 		errors.add(:video_url, "could not be parsed")
	# 	end
	# end

	# def validate_video_url?
	# 	(new_record? || video_url_changed?)
	# end
end
