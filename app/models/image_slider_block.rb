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

class ImageSliderBlock < ContentBlock
	has_many :image_attachments, as: :resource, dependent: :destroy
	accepts_nested_attributes_for :image_attachments, allow_destroy: true
end
