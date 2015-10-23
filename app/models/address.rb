# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  name       :string
#  address_1  :string
#  address_2  :string
#  zipcode    :string
#  city       :string
#  country    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Address < ActiveRecord::Base
	has_one :event

	def any_present?
		[name, address_1, address_2, zipcode, city, country].any? { |w| w.present? }
	end
end
