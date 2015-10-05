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

require 'rails_helper'

RSpec.describe Address, type: :model do
  
  describe 'validations' do
  	
  end

  describe 'associations' do
    it { should have_one :event }
  end

end
