# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  title             :string
#  excerpt           :text
#  content           :text
#  starts_at         :datetime
#  ends_at           :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  address_id        :integer
#  publish_at        :datetime
#  published         :boolean
#  max_registrations :integer
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  
  describe 'validations' do
  	it { should validate_presence_of :title }
  end

  describe 'associations' do
    it { should belong_to :address }
    it { should have_many :image_attachments }
    it { should have_many :registrations }
    it { should have_many :users }
    it 'should not be possible to set end date prior til start date' do
      event = build(:event, starts_at: 1.day.ago.to_s(:formatted), ends_at: 2.days.ago.to_s(:formatted))
      expect(event).not_to be_valid
    end
    
  	it 'has many speakers'
  	it 'has many registrations'
  	it 'has many attendees'
  end

end