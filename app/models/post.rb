# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  excerpt    :text
#  content    :text
#  publish_at :datetime
#  published  :boolean
#  lab_id     :integer
#

class Post < ActiveRecord::Base
  include Taggable
  include Schedulable
  
	validates_presence_of :title

  has_many :image_attachments, as: :resource, dependent: :destroy
  accepts_nested_attributes_for :image_attachments, allow_destroy: true

	has_many :content_blocks, as: :resource, dependent: :destroy
	has_many :image_blocks, source: 'ContentBlock', as: :resource
	has_many :image_slider_blocks, source: 'ContentBlock', as: :resource
	has_many :text_blocks, source: 'ContentBlock', as: :resource
	has_many :video_blocks, source: 'ContentBlock', as: :resource

	accepts_nested_attributes_for :content_blocks, allow_destroy: true
	accepts_nested_attributes_for :image_blocks, allow_destroy: true
	accepts_nested_attributes_for :image_slider_blocks, allow_destroy: true
	accepts_nested_attributes_for :text_blocks, allow_destroy: true
	accepts_nested_attributes_for :video_blocks, allow_destroy: true

  has_many :project_partnerships, as: :resource, dependent: :destroy
  accepts_nested_attributes_for :project_partnerships, allow_destroy: true
  has_many :project_partners, through: :project_partnerships

  belongs_to :lab

	def featured_image
		image_attachments.first
	end

end
