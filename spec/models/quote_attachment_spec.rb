# == Schema Information
#
# Table name: quote_attachments
#
#  id         :integer          not null, primary key
#  quote      :text
#  author     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe QuoteAttachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
