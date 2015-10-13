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

class TextBlock < ContentBlock
	has_one :text_attachment, as: :resource, dependent: :destroy

	accepts_nested_attributes_for :text_attachment, allow_destroy: true

end
