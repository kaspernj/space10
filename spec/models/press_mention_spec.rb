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

require 'rails_helper'

RSpec.describe PressMention, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
