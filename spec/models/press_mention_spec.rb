# == Schema Information
#
# Table name: press_mentions
#
#  id           :integer          not null, primary key
#  title        :string
#  excerpt      :text
#  url          :string
#  source       :string
#  published_at :datetime
#  image        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  published    :boolean
#  featured     :boolean
#

require 'rails_helper'

RSpec.describe PressMention, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :source }
  end

  describe 'associations' do
  end
end
