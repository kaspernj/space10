# == Schema Information
#
# Table name: events
#
#  id                    :integer          not null, primary key
#  title                 :string
#  excerpt               :text
#  content               :text
#  starts_at             :datetime
#  ends_at               :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  address_id            :integer
#  publish_at            :datetime
#  published             :boolean
#  max_registrations     :integer
#  slug                  :string
#  lab_id                :integer
#  project_partners_text :text
#  project_people_text   :text
#

class Event < ActiveRecord::Base
  include Planable
  include Schedulable

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  include PgSearch
  multisearchable against: [:title, :excerpt]

	validates_presence_of :title, :starts_at
  validate :end_date_after_start_date

  has_many :image_attachments, as: :resource, dependent: :destroy
  accepts_nested_attributes_for :image_attachments, allow_destroy: true

  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations

  belongs_to :address, dependent: :destroy
  accepts_nested_attributes_for :address

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

  belongs_to :lab


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

  def secondary_image
    image_attachments.second
  end

  def secondary_image_url(size = nil)
    if secondary_image.present?
      secondary_image.image_url(size)
    else
      ActionController::Base.helpers.asset_path("image_fallback/" + [size, "default.png"].compact.join('_'))
    end
  end

  def fully_booked?
    (max_registrations || 0) > 0 && max_registrations < registrations.confirmed.count
  end

  def timespan
    # if ends_at.present?
    #   if starts_at.to_date == ends_at.to_date
    #     starts_at.strftime("%l.%M%p") + " - " + ends_at.strftime("%l.%M%p")
    #   else
    #     starts_at.strftime("%B %e %I.%M%p") + " - " + ends_at.strftime("%B %e %I.%M%p")
    #   end
    # else
    #   starts_at.strftime("%I.%M%p")
    # end
    start_date = starts_at.strftime("%B %e")
    start_hour = starts_at.strftime("%l")
    start_minute = starts_at.strftime("%M").gsub("00",'')
    start_ampm = starts_at.strftime("%p")
    start_hm = [start_hour, start_minute].reject(&:blank?).join(".")
    start_hm_p = [start_hm, start_ampm].join("")

    if ends_at.present?
      end_date = ends_at.strftime("%B %e")
      end_hour = ends_at.strftime("%l")
      end_minute = ends_at.strftime("%M").gsub("00",'')
      end_ampm = ends_at.strftime("%p")
      end_hm = [end_hour, end_minute].reject(&:blank?).join(".")
      end_hm_p = [end_hm, end_ampm].join("")

      if starts_at.to_date == ends_at.to_date
        start_time = start_hm_p
        end_time = end_hm_p
      else
        start_time = [start_date,start_hm_p].join(" ")
        end_time = [end_date,end_hm_p].join(" ")
      end
    end
  
    [start_time, end_time].join(" - ")    

  end

end
