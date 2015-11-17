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
#  latitude    :float
#  longitude   :float
#  website     :string
#  featured    :boolean
#  email       :string
#

class Profile < ActiveRecord::Base
	include Taggable

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  mount_uploader :image, AvatarUploader
  geocoded_by :location
  after_validation :geocode, if: lambda{ |obj| obj.location_changed? }
	
	validates_presence_of :title, :type
  # validates_format_of :website, with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i, allow_blank: true

  scope :published, -> { where('published = true') }
	scope :featured, -> { where('featured = true') }

end
