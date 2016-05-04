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

FactoryGirl.define do
  factory :profile do
    title "Profile Title"
		description "Profile Description"
		location "Copenhagen, Denmark"
		type ""
		published true
  end
end
