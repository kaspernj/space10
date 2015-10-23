# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  tag_id        :integer
#  resource_type :string
#  resource_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Tagging, type: :model do
  describe 'validations' do
  end

  describe 'associations' do
  	it { should belong_to :resource }
  	it { should belong_to :tag }
  end
end
