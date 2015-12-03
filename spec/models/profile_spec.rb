# == Schema Information
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  location    :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  published   :boolean
#  image       :string
#  latitude    :float
#  longitude   :float
#  website     :string
#  featured    :boolean
#  email       :string
#  slug        :string
#  tagline     :string
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
  	it { should validate_presence_of :title }
  	it { should validate_presence_of :type }

    # it { should_not allow_value('blabla').for :website }

    # it { should allow_value('http://example.com').for :website }
    # it { should allow_value('https://www.example.com').for :website }
    # it { should allow_value('www.example.com').for :website }
  end

  describe 'associations' do
  end
end
