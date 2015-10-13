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

class TextAttachment < ActiveRecord::Base
	belongs_to :resource, polymorphic: true
end
