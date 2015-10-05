# == Schema Information
#
# Table name: image_attachments
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  title         :string
#  description   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  image         :string
#

require 'rails_helper'

RSpec.describe ImageAttachment, type: :model do
  describe "validations" do
  	it { should validate_presence_of :image }
  end

  describe "associations" do
  	it { should belong_to :resource }
  end
end
