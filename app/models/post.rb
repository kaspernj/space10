# == Schema Information
#
# Table name: posts
#
#  id                    :integer          not null, primary key
#  title                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  excerpt               :text
#  content               :text
#  publish_at            :datetime
#  published             :boolean
#  lab_id                :integer
#  project_partners_text :text
#  project_people_text   :text
#  slug                  :string
#  rateable              :boolean
#

class Post < ActiveRecord::Base
  has_many :taggings, as: :resource, dependent: :destroy
  has_many :tags, through: :taggings, source: :post_tag
  def tag_tokens=(tokens)
    self.tag_ids = PostTag.ids_from_tokens(tokens)
  end
  include Taggable
  include Schedulable

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  include PgSearch
  multisearchable against: [:title, :excerpt]
  
	validates_presence_of :title

  has_many :image_attachments, as: :resource, dependent: :destroy
  accepts_nested_attributes_for :image_attachments, allow_destroy: true

	has_many :content_blocks, as: :resource, dependent: :destroy
	has_many :image_blocks, source: 'ContentBlock', as: :resource
	has_many :image_slider_blocks, source: 'ContentBlock', as: :resource
	has_many :text_blocks, source: 'ContentBlock', as: :resource
  has_many :video_blocks, source: 'ContentBlock', as: :resource
	has_many :quote_blocks, source: 'ContentBlock', as: :resource

	accepts_nested_attributes_for :content_blocks, allow_destroy: true
	accepts_nested_attributes_for :image_blocks, allow_destroy: true
	accepts_nested_attributes_for :image_slider_blocks, allow_destroy: true
	accepts_nested_attributes_for :text_blocks, allow_destroy: true
  accepts_nested_attributes_for :video_blocks, allow_destroy: true
	accepts_nested_attributes_for :quote_blocks, allow_destroy: true

  has_many :company_partnerships, source: 'ProjectPartnership', as: :resource, dependent: :destroy
  accepts_nested_attributes_for :company_partnerships, allow_destroy: true
  has_many :project_partners, through: :company_partnerships

  has_many :person_partnerships, source: 'ProjectPartnership', as: :resource, dependent: :destroy
  accepts_nested_attributes_for :person_partnerships, allow_destroy: true
  has_many :project_people, through: :person_partnerships

  has_many :ratings, as: :resource

  belongs_to :lab

  default_scope { order('publish_at desc') }

	def featured_image
    image_attachments.first
  end

  def featured_image_url(size = nil)
    if featured_image.present?
      featured_image.image_url(size)
    else
      ActionController::Base.helpers.asset_path("image_fallback/" + [size, "default.png"].compact.join('_'))
    end
  end

end
