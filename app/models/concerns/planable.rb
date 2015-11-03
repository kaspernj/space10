module Planable
	extend ActiveSupport::Concern

  included do
    scope :future, -> { where("starts_at > :d AND (ends_at IS NULL OR ends_at > :d)", d: Time.zone.now) }
    scope :current_or_future, -> { where("ends_at > :d OR starts_at > :d", d: Time.zone.now) }
    scope :historic, -> { where("starts_at < :d AND (ends_at IS NULL OR ends_at < :d)", d: Time.zone.now) }
    default_scope { order("starts_at desc") }
  end

	def starts_at=(date)
   begin
     parsed = Time.zone.parse(date)
     super parsed
   rescue
     date         
   end
  end

  def ends_at=(date)
   begin
     parsed = Time.zone.parse(date)
     super parsed
   rescue
     date         
   end
  end

  def historic?
    if starts_at < Time.zone.now && (ends_at == nil || ends_at < Time.zone.now)
      return true
    else
      return false
    end
  end

  def current?
    starts_at < Time.zone.now && Time.zone.now < ends_at
  end

  def future?
    starts_at > Time.zone.now && (Time.zone.now < ends_at || ends_at.blank?)
  end

  module ClassMethods
    def current_or_next
      current_or_future.first
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