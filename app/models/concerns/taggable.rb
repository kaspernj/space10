module Taggable
	extend ActiveSupport::Concern

	included do
		has_many :taggings, as: :resource, dependent: :destroy
		has_many :tags, through: :taggings

		attr_reader :tag_tokens
	end

  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end
end