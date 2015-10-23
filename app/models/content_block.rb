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

class ContentBlock < ActiveRecord::Base
	validates_presence_of :type
	
	belongs_to :resource, polymorphic: true

	default_scope { order(:row_order) }
end
