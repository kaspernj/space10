# == Schema Information
#
# Table name: text_attachments
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  content       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe TextAttachment, type: :model do
  describe 'validations' do
  end

  describe 'associations' do
  end
end
