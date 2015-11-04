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
#  image           :string
#

class User < ActiveRecord::Base
	mount_uploader :image, AvatarUploader
	has_secure_password validations: :validate_password?
	validates_length_of :password, minimum: 8, if: :validate_password?

	VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
	
	validates :email, presence: true,
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	validates_presence_of :name

	before_create { generate_token(:auth_token) }
	after_create :deliver_welcome_mail

	has_many :authentications, dependent: :destroy
	has_many :registrations, dependent: :destroy
	has_many :events,  -> { current_or_future }, through: :registrations
	has_many :historic_events,  -> { historic }, through: :registrations, class_name: 'Event'

	has_many :profile_authorizations, dependent: :destroy
	has_many :company_profiles, through: :profile_authorizations

	has_one :personal_profile

	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

	def self.from_omniauth(omniauth)
		find_or_initialize_by(email: omniauth['info']['email']).tap do |user|
			user.email = omniauth['info']['email']
			user.name = omniauth['info']['name']
			user.remote_image_url = omniauth['info']['image'] if user.image.blank?
			user.password = SecureRandom.urlsafe_base64(8) if user.new_record?
		end
	end

	def validate_password?
		(new_record? || password_digest_changed?)
	end

	def deliver_welcome_mail
		UserMailer.welcome(self.id).deliver_now
	end

end
