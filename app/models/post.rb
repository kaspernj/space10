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
#

class Post < ActiveRecord::Base
	validates_presence_of :title

	has_many :content_blocks, as: :resource
	has_many :image_blocks, source: 'ContentBlock', as: :resource
	has_many :image_slider_blocks, source: 'ContentBlock', as: :resource
	has_many :text_blocks, source: 'ContentBlock', as: :resource
	has_many :video_blocks, source: 'ContentBlock', as: :resource

	accepts_nested_attributes_for :content_blocks, allow_destroy: true
	accepts_nested_attributes_for :image_blocks, allow_destroy: true
	accepts_nested_attributes_for :image_slider_blocks, allow_destroy: true
	accepts_nested_attributes_for :text_blocks, allow_destroy: true
	accepts_nested_attributes_for :video_blocks, allow_destroy: true

	scope :published, -> { where('published = true AND publish_at < ?', DateTime.now) }
  scope :unpublished, -> { where('published = false OR publish_at > ?', DateTime.now) }
  scope :scheduled, -> { where('published = true AND publish_at > ?', DateTime.now) }

  def status
    if published? && publish_at < DateTime.now
      :published
    elsif published? && publish_at > DateTime.now
      :scheduled
    elsif !published?
      :draft
    end 
  end

  def publish_at=(date)
   begin
     parsed = DateTime.strptime(date + " CEST",'%m/%d/%Y %H:%M %Z')
     super parsed
   rescue
     date         
   end
  end
end
