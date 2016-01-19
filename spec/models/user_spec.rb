# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  password_digest        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  auth_token             :string
#  admin                  :boolean          default(FALSE)
#  name                   :string
#  birthday               :date
#  gender                 :string
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do
  	it { should respond_to :name }
    
    it { should validate_presence_of :password }
    it { should validate_length_of(:password).is_at_least(8) }
  	
    it { should validate_presence_of :email }
  	it { should validate_uniqueness_of :email }

  	it { should allow_value('d@friis.me').for(:email) }
  	it { should allow_value('daniel.friis@friis.com').for(:email) }

  	it { should_not allow_value('daniel.friis@friis').for(:email) }
  	it { should_not allow_value('danielriis').for(:email) }

    it { should respond_to :admin }
    it { should respond_to :birthday }
    it { should respond_to :gender }

  	it 'should validate case insensitive uniqueness' do
  		create(:user, email: "test@example.com", password: "12345678")
  		expect(build(:user, email: "Test@example.com")).to_not be_valid
  	end

    it 'should generate token before create' do
      expect(create(:user).auth_token).to be_present
    end

  end

  describe 'associations' do
    it { should have_many :authentications }
    it { should have_many :registrations }
    it { should have_many :events }

    it { should have_many :profile_authorizations }
    it { should have_one :personal_profile }
    it { should have_many :company_profiles }
  end

end
