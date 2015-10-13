# == Schema Information
#
# Table name: content_blocks
#
#  id            :integer          not null, primary key
#  type          :string
#  resource_type :string
#  resource_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  row_order     :integer
#

require 'rails_helper'

RSpec.describe ContentBlock, type: :model do
  describe 'validations' do

  end

  describe 'associations' do
  	it { should belong_to :resource }
  end
end
