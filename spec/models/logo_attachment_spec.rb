# == Schema Information
#
# Table name: logo_attachments
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  image         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe LogoAttachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
