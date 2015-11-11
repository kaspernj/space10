# == Schema Information
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  location    :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  published   :boolean
#  image       :string
#

class Profile < ActiveRecord::Base
	include Taggable
  mount_uploader :image, AvatarUploader
  geocoded_by :location
  after_validation :geocode, if: lambda{ |obj| obj.location_changed? }
	
	validates_presence_of :title, :type

	scope :published, -> { where('published = true') }
end
