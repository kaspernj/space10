# == Schema Information
#
# Table name: registrations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  confirmed  :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Registration < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

	validates_presence_of :user_id, :event_id

	scope :confirmed, -> { where(confirmed: true) }

	def confirmation_status
		if confirmed?
			:confirmed
		elsif !self.confirmed? && event.fully_booked?
			:waiting
		else
			:unconfirmed
		end
	end
end
