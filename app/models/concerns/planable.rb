module Planable
	extend ActiveSupport::Concern

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

  def publish_at=(date)
   begin
     parsed = Time.zone.parse(date)
     super parsed
   rescue
     date         
   end
  end

end