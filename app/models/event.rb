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
	validates_presence_of :title, :starts_at

  belongs_to :address
  has_many :image_attachments, as: :resource
  has_many :registrations
  has_many :users, through: :registrations

  accepts_nested_attributes_for :address, :image_attachments

  scope :published, -> { where('published = true AND publish_at < ?', DateTime.now) }
  scope :unpublished, -> { where('published = false OR publish_at > ?', DateTime.now) }
  scope :scheduled, -> { where('published = true AND publish_at > ?', DateTime.now) }

  scope :future, -> { where("starts_at > :d AND (ends_at IS NULL OR ends_at > :d)", d: DateTime.now) }
  scope :historic, -> { where("starts_at < :d AND (ends_at IS NULL OR ends_at < :d)", d: DateTime.now) }

  def status
    if published? && publish_at < DateTime.now
      :published
    elsif published? && publish_at > DateTime.now
      :scheduled
    elsif !published?
      :draft
    end 
  end

  def starts_at=(date)
   begin
     parsed = DateTime.strptime(date + " CEST",'%m/%d/%Y %H:%M %Z')
     super parsed
   rescue
     date         
   end
  end

  def ends_at=(date)
   begin
     parsed = DateTime.strptime(date + " CEST",'%m/%d/%Y %H:%M %Z')
     super parsed
   rescue
     date         
   end
  end

  def publish_at=(date)
   begin
     parsed = DateTime.strptime(date + " CEST",'%m/%d/%Y %H:%M %Z')
     super parsed
   rescue
     date         
   end
  end

  def historic?
    if starts_at < DateTime.now && (ends_at == nil || ends_at < DateTime.now)
      return true
    else
      return false
    end
  end

end
