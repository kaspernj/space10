# == Schema Information
#
# Table name: labs
#
#  id         :integer          not null, primary key
#  title      :string
#  subtitle   :string
#  published  :boolean
#  starts_at  :datetime
#  ends_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lab < ActiveRecord::Base
  include Planable

	validates_presence_of :title
	validate :end_date_after_start_date

	scope :published, -> { where('published = true') }

	def timespan
		if starts_at.present? && ends_at.present?
			if starts_at.year == ends_at.year
				starts_at.strftime("%B %d") + " &mdash; " + ends_at.strftime("%B %d, %Y")
			else
				starts_at.strftime("%B %d, %Y") + " &mdash; " + ends_at.strftime("%B %d, %Y")
			end
		else
			(starts_at || ends_at).strftime("%B %d, %Y")
		end		
	end

	has_many :posts
	has_many :events

end
