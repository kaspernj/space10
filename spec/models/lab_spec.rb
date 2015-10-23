# == Schema Information
#
# Table name: labs
#
#  id         :integer          not null, primary key
#  title      :string
#  subtitle   :string
#  published  :boolean
#  starts_at  :datetime
#  ends_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Lab, type: :model do
  describe 'validations' do
  	it { should validate_presence_of :title }
  	it 'should not be possible to set end date prior til start date' do
  		lab = build(:lab, starts_at: 1.day.ago.to_s(:formatted), ends_at: 2.days.ago.to_s(:formatted))
  		expect(lab).not_to be_valid
  	end
  end

  describe 'associations' do
  end
end
