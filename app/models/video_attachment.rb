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
#  image         :string
#

class VideoAttachment < ActiveRecord::Base
	belongs_to :resource, polymorphic: true

	validates_presence_of :provider, :video_id

  scope :featured, -> { where('featured = true') }

	def embed_src
		if provider.downcase == 'vimeo'
			"//player.vimeo.com/video/#{video_id}?autoplay=1"
		elsif provider.downcase == 'youtube'
			"http://www.youtube.com/embed/#{video_id}?autoplay=1"
		end
	end
end
