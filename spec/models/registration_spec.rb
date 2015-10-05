# == Schema Information
#
# Table name: registrations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_id   :integer
#  confirmed  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Registration, type: :model do
  
  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :event_id }
  	
    it { should respond_to :confirmed }
  end

  describe 'associations' do
    it { should belong_to :event }
    it { should belong_to :user }
  end

end
