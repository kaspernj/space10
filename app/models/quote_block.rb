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
#  title         :string
#  description   :string
#

class QuoteBlock < ContentBlock
  has_one :quote_attachment, as: :resource, dependent: :destroy
  accepts_nested_attributes_for :quote_attachment, allow_destroy: true

  default_scope { includes(:quote_attachment) }
end
