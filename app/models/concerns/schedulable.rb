module Schedulable
	extend ActiveSupport::Concern

	included do
		scope :published, -> { where('published = true AND publish_at < ?', DateTime.now).order('publish_at DESC') }
	  scope :unpublished, -> { where('published = false OR publish_at > ?', DateTime.now) }
	  scope :scheduled, -> { where('published = true AND publish_at > ?', DateTime.now) }

    default_scope { order('publish_at desc') }
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

  def publish_at=(date)
   begin
     parsed = Time.zone.parse(date)
     super parsed
   rescue
     date         
   end
  end

  def published_at
    publish_at
  end

end