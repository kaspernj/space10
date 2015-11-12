# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  auth_token      :string
#  admin           :boolean          default(FALSE)
#  name            :string
#  birthday        :date
#  gender          :string
#

class User < ActiveRecord::Base
	has_secure_password validations: :validate_password?
	validates_length_of :password, minimum: 8, if: :validate_password?

	VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
	
	validates :email, presence: true,
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	validates_presence_of :name

	before_create { generate_token(:auth_token) }
	after_create :deliver_welcome_mail
	after_save :update_personal_profile

	has_many :authentications, dependent: :destroy
	has_many :registrations, dependent: :destroy
	has_many :events,  -> { current_or_future }, through: :registrations
	has_many :historic_events,  -> { historic }, through: :registrations, class_name: 'Event'

	has_many :profile_authorizations, dependent: :destroy
	has_many :company_profiles, through: :profile_authorizations

	has_one :personal_profile
	accepts_nested_attributes_for :personal_profile

	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

	def self.from_omniauth(omniauth)
		find_or_initialize_by(email: omniauth['info']['email']).tap do |user|
			user.email = omniauth['info']['email']
			user.name = (omniauth['info']['name'] || [omniauth['info']['first_name'],omniauth['info']['last_name']].join(" "))
			user.birthday = Date.strptime(omniauth['extra']['raw_info']['birthday'],'%m/%d/%Y') rescue nil
			user.gender = omniauth['extra']['raw_info']['gender'] rescue nil
			user.personal_profile = PersonalProfile.from_omniauth(user, omniauth)
			user.password = SecureRandom.urlsafe_base64(8) if user.new_record?
		end
	end

	def validate_password?
		(new_record? || password_digest_changed?)
	end

	def deliver_welcome_mail
		UserMailer.welcome(self.id).deliver_now
	end

	def update_personal_profile
		PersonalProfile.find_or_initialize_by(user: self).tap do |profile|
			profile.title = self.name
			profile.save
		end
	end

	def first_name
		name.split(' ').first
	end

end
