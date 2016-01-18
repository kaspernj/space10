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

class QuoteAttachment < ActiveRecord::Base
end
