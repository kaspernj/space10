module Publishable
	extend ActiveSupport::Concern

	included do
		scope :published, -> { where('published = true AND publish_at < ?', DateTime.now).order('publish_at DESC') }
	  scope :unpublished, -> { where('published = false OR publish_at > ?', DateTime.now) }
	  scope :scheduled, -> { where('published = true AND publish_at > ?', DateTime.now) }
	end

  def status
    if published? && publish_at < DateTime.now
      :published
    elsif published? && publish_at > DateTime.now
      :scheduled
    elsif !published?
      :draft
    end 
  end

end