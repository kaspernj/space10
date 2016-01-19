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
#  published    :boolean
#  featured     :boolean
#

class PressMention < ActiveRecord::Base
  mount_uploader :image, PressImageUploader

  validates_presence_of :title, :source

  scope :published, -> { where('published = true') }
  scope :featured, -> { where('featured = true') }
  default_scope { order('created_at DESC') }
end
