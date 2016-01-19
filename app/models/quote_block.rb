class QuoteBlock < ContentBlock
  has_one :quote_attachment, as: :resource, dependent: :destroy
  accepts_nested_attributes_for :quote_attachment, allow_destroy: true

  default_scope { includes(:quote_attachment) }
end
