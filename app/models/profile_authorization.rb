# == Schema Information
#
# Table name: profile_authorizations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  profile_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProfileAuthorization < ActiveRecord::Base
	belongs_to :user
	belongs_to :company_profile
end
