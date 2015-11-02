# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  title             :string
#  excerpt           :text
#  content           :text
#  starts_at         :datetime
#  ends_at           :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  address_id        :integer
#  publish_at        :datetime
#  published         :boolean
#  max_registrations :integer
#

class Event < ActiveRecord::Base
  include Planable
  include Schedulable

	validates_presence_of :title, :starts_at
  validate :end_date_after_start_date

  belongs_to :address, dependent: :destroy
  has_many :image_attachments, as: :resource, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :image_attachments, allow_destroy: true


  def featured_image
    image_attachments.first
  end

  def featured_image_url(size = nil)
    if featured_image.present?
      featured_image.image_url(size)
    else
      "fallback/" + [size, "default.png"].compact.join('_')
    end
  end

  def secondary_image
    image_attachments.second
  end

  def fully_booked?
    (max_registrations || 0) > 0 && max_registrations < registrations.confirmed.count
  end

  def timespan
    if ends_at.present?
      if starts_at.to_date == ends_at.to_date
        starts_at.strftime("%I.%M%p") + " - " + ends_at.strftime("%I.%M%p")
      else
        starts_at.strftime("%B %e %I.%M%p") + " - " + ends_at.strftime("%B %e %I.%M%p")
      end
    else
      starts_at.strftime("%I.%M%p")
    end
  end

end
