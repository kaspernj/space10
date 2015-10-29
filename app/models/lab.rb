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
	default_scope { order('starts_at asc') }

	def timespan
		if starts_at.present? && ends_at.present?
			if starts_at.year == ends_at.year
				starts_at.strftime("%B") + " &mdash; " + ends_at.strftime("%B %Y")
			else
				starts_at.strftime("%B %Y") + " &mdash; " + ends_at.strftime("%B %Y")
			end
		else
			(starts_at || ends_at).strftime("%B %Y")
		end		
	end

	def current?
		starts_at.beginning_of_month < DateTime.now && DateTime.now < ends_at.end_of_month
	end

private

	def end_date_after_start_date
		return if [starts_at.blank?, ends_at.blank?].any?
		if ends_at < starts_at
			errors.add(:ends_at, 'must be greater than the start date')
		end
	end

end
