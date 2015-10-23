# == Schema Information
#
# Table name: video_attachments
#
#  id            :integer          not null, primary key
#  title         :string
#  description   :string
#  featured      :boolean
#  provider      :string
#  video_id      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  video_url     :string
#  resource_type :string
#  resource_id   :integer
#  image         :string
#

require 'rails_helper'

RSpec.describe VideoAttachment, type: :model do
  describe 'validations' do
  	it { should validate_presence_of :provider }
  	it { should validate_presence_of :video_id }
  end

  describe 'associations' do
  	it { should belong_to :resource }
  end
end
