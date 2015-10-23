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
#

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
  	it { should validate_presence_of :title }
  	it { should validate_presence_of :type }
  end

  describe 'associations' do
  	it { should have_one :image_attachment }
  end
end
