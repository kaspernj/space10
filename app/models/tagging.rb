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
  belongs_to :profile_tag, foreign_key: 'tag_id', class_name: 'ProfileTag'
	belongs_to :post_tag, foreign_key: 'tag_id', class_name: 'PostTag'
end
