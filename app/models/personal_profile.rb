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
#

class PersonalProfile < Profile
	belongs_to :user

  def self.from_omniauth(user,omniauth)
    find_or_initialize_by(user: user).tap do |profile|
      profile.title = user.name if profile.title.blank?
      profile.remote_image_url = omniauth['info']['image'] if profile.image.blank?
    end
  end
end
