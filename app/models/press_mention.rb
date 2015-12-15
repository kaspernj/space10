# == Schema Information
#
# Table name: press_mentions
#
#  id           :integer          not null, primary key
#  title        :string
#  excerpt      :text
#  url          :string
#  source       :string
#  published_at :datetime
#  image        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PressMention < ActiveRecord::Base
  mount_uploader :image, PressImageUploader
end
