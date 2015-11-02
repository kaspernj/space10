# == Schema Information
#
# Table name: image_attachments
#
#  id            :integer          not null, primary key
#  resource_type :string
#  resource_id   :integer
#  title         :string
#  description   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  image         :string
#  row_order     :integer
#

class ImageAttachment < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	belongs_to :resource, polymorphic: true

	validates_presence_of :image

	default_scope { order(:row_order) }
end
