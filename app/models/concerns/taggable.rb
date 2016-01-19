module Taggable
	extend ActiveSupport::Concern

	included do
		attr_reader :tag_tokens
	end

  module ClassMethods
  	def where_tagged_with(tags)
      if tags.present?
  		  joins(:tags).where(:tags => {:title => tags})
      else
        all
      end
  	end
  end
end