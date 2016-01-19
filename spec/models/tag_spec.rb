# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#

require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
  	it { should validate_uniqueness_of :title }
  end

  describe 'associations' do
  	it { should have_many :taggings }
  end
end
