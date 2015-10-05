# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  auth_token      :string
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
	has_secure_password validations: :validate_password?
	validates_length_of :password, minimum: 8, if: :validate_password?

	VALID_EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
	
	validates :email, presence: true,
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }

	validates_presence_of :first_name, :last_name

	before_create { generate_token(:auth_token) }

	has_many :authentications
	has_many :registrations
	has_many :events, through: :registrations

	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end

	def self.from_omniauth(omniauth)
		find_or_initialize_by(email: omniauth['info']['email']).tap do |user|
			user.email = omniauth['info']['email']
			user.first_name = omniauth['info']['first_name']
			user.last_name = omniauth['info']['last_name']
			if user.new_record?
				user.password = 'password123'
				# send password in email
			end
			user.save!
		end
	end

	def full_name
		[first_name, last_name].reject(&:empty?).join(' ')
	end

	def validate_password?
		(new_record? || password_digest_changed?)
	end

end
