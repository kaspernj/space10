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
    
  	it 'has many speakers'
  	it 'has many registrations'
  	it 'has many attendees'
  end

end
