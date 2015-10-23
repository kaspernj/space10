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
#

class Profile < ActiveRecord::Base
	include Taggable
	
	validates_presence_of :title, :type

	has_one :image_attachment, as: :resource, dependent: :destroy
	accepts_nested_attributes_for :image_attachment, allow_destroy: true

	scope :published, -> { where('published = true') }
end
