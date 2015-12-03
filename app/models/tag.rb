# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
	validates_presence_of :title
	validates_uniqueness_of :title

	has_many :taggings, dependent: :destroy
	has_many :profiles, through: :taggings, source: :resource, source_type: 'Profile'

	def self.tokens(query)
	  tags = where("lower(title) like ?", "%#{query.downcase}%")
	  exact_match = where("lower(title) like ?", "#{query.downcase}")
	  if tags.empty?
	    [{id: "<<<#{query}>>>", title: "New: \"#{query}\""}]
	  elsif exact_match.present?
	    tags
	  else
	  	tags + [{id: "<<<#{query}>>>", title: "New: \"#{query}\""}]
	  end
	end

	def self.ids_from_tokens(tokens)
	  tokens.gsub!(/<<<(.+?)>>>/) { create!(title: $1).id }
	  tokens.split(',')
	end
end
