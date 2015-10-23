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
  include Publishable

	validates_presence_of :title, :starts_at
  validate :end_date_after_start_date

  belongs_to :address, dependent: :destroy
  has_many :image_attachments, as: :resource, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :users, through: :registrations

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :image_attachments, allow_destroy: true

  scope :future, -> { where("starts_at > :d AND (ends_at IS NULL OR ends_at > :d)", d: Time.current) }
  scope :historic, -> { where("starts_at < :d AND (ends_at IS NULL OR ends_at < :d)", d: Time.current) }

  def historic?
    if starts_at < Time.current && (ends_at == nil || ends_at < Time.current)
      return true
    else
      return false
    end
  end

  def feature_image
    if image_attachments.any?
      image_attachments.first.image
    else
      "fallback/medium_default.png"
    end
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

private

  def end_date_after_start_date
    return if [starts_at.blank?, ends_at.blank?].any?
    if ends_at < starts_at
      errors.add(:ends_at, 'must be greater than the start date')
    end
  end

end
