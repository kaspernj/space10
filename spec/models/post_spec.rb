# == Schema Information
#
# Table name: posts
#
#  id                    :integer          not null, primary key
#  title                 :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  excerpt               :text
#  content               :text
#  publish_at            :datetime
#  published             :boolean
#  lab_id                :integer
#  project_partners_text :text
#  project_people_text   :text
#  slug                  :string
#  rateable              :boolean
#

require 'rails_helper'

RSpec.describe Post, type: :model do
	describe 'validations' do
		it { should validate_presence_of :title }
		it { should respond_to :excerpt }
		it { should respond_to :content }
		it { should respond_to :published }
		it { should respond_to :publish_at }
	end

	describe 'associations' do
		it { should have_many :image_attachments }
		it { should have_many :content_blocks }
		it { should have_many :image_blocks }
		it { should have_many :image_slider_blocks }
		it { should have_many :text_blocks }
		it { should have_many :video_blocks }

		it { should have_many :taggings }
		it { should have_many :tags }
		# it { should have_many :authors }

		it { should have_many :project_partners }

		it { should have_many :project_people }

		it { should belong_to :lab }
	end
end
