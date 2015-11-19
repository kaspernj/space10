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
#

class CompanyProfile < Profile
	has_many :profile_authorizations, as: :profile
	has_many :users, through: :profile_authorizations

  has_one :logo_attachment, as: :resource, dependent: :destroy
  accepts_nested_attributes_for :logo_attachment, allow_destroy: true

  def logo
    logo_attachment
  end

  def logo_url(size = nil)
    if logo_attachment.present?
      logo_attachment.image_url(size)
    else
      ActionController::Base.helpers.asset_path("logo_fallback/" + [size, "default.png"].compact.join('_'))
    end
  end
end
