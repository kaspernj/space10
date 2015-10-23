# == Schema Information
#
# Table name: authentications
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  provider         :string
#  uid              :string
#  oauth_token      :string
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Authentication < ActiveRecord::Base
	validates_presence_of :user_id, :provider, :uid, :oauth_token

	belongs_to :user

	def self.from_omniauth(omniauth)
		find_or_initialize_by(provider: omniauth['provider'], uid: omniauth['uid']).tap do |auth|
			auth.provider = omniauth['provider']
			auth.uid = omniauth['uid']
			auth.oauth_token = omniauth['credentials']['token']
    	auth.oauth_expires_at = Time.at(omniauth['credentials']['expires_at'].to_i)
			auth.user = User.from_omniauth(omniauth)
		end
	end
end
