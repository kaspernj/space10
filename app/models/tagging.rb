# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  tag_id        :integer
#  resource_type :string
#  resource_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Tagging < ActiveRecord::Base
	belongs_to :resource, polymorphic: true
	belongs_to :tag
end
