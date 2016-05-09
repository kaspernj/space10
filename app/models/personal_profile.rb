# == Schema Information
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  location    :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  published   :boolean
#  image       :string
#  latitude    :float
#  longitude   :float
#  website     :string
#  featured    :boolean
#  email       :string
#  slug        :string
#  tagline     :string
#  claim_token :string
#

class PersonalProfile < Profile
	belongs_to :user
  validates :user_id, uniqueness: true, allow_blank: true

  def self.from_omniauth(user,omniauth)
    find_or_initialize_by(user: user).tap do |profile|
      profile.title = user.name if profile.title.blank?
      profile.remote_image_url = (omniauth['extra']['raw_info']['pictureUrls']['values'].first rescue omniauth['info']['image']) if profile.image.blank?
      profile.location = (omniauth['info']['location']['name'] rescue omniauth['info']['location']) if profile.location.blank?
    end
  end
end
