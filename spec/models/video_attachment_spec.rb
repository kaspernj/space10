# == Schema Information
#
# Table name: video_attachments
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  featured    :boolean
#  provider    :string
#  video_id    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  video_url   :string
#

require 'rails_helper'

RSpec.describe VideoAttachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
