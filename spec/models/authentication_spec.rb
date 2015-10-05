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

require 'rails_helper'

RSpec.describe Authentication, type: :model do
  
  describe 'validations' do
  	it { should validate_presence_of :provider }
  	it { should validate_presence_of :uid }
  	it { should validate_presence_of :user_id }
  	it { should validate_presence_of :oauth_token }
  end

  describe 'associations' do
  	it { should belong_to :user }
  end

end
