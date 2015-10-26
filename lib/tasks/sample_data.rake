require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    # Rake::Task['db:reset'].invoke
    Post.all.each(&:destroy)
    Tag.all.each(&:destroy)
    Event.all.each(&:destroy)
    Lab.all.each(&:destroy)
    Profile.all.each(&:destroy)

    5.times do |i|
    	Tag.create(title: Faker::Commerce.department(1))
  	end

		10.times do |i|
			Post.new.tap do |post|
				post.title = [Faker::Company.bs, Faker::Company.bs].join(" ").capitalize
				post.excerpt = Faker::Lorem.paragraph(5)
				post.content = ["<p>", Faker::Lorem.paragraph(5), "</p>", "<p>", Faker::Lorem.paragraph(7), "</p>"].join("")
				post.publish_at = Faker::Time.between(DateTime.now - 10, DateTime.now).to_s(:formatted)
				post.published = true

				3.times do |a|
					post.image_attachments.new.tap do |attachment|
						attachment.image = File.open(File.join(Rails.root, "spec/factories/images/space_#{i + a + 1}.jpg"))
					end
				end

				post.save
			end
		end

		3.times do |i|
			Event.new.tap do |event|
				event.title = [Faker::Company.bs, Faker::Company.bs].join(" ").capitalize
				event.excerpt = Faker::Lorem.paragraph(5)
				event.content = ["<p>", Faker::Lorem.paragraph(5), "</p>", "<p>", Faker::Lorem.paragraph(7), "</p>"].join("")
				event.publish_at = Faker::Time.between(DateTime.now - 10, DateTime.now).to_s(:formatted)
				event.published = true
				start_datetime = Faker::Time.between(DateTime.now - 3, DateTime.now + 30)
				event.starts_at = start_datetime.to_s(:formatted)
				event.ends_at = (start_datetime + (rand(3) + 1).hours).to_s(:formatted)
				event.image_attachments.new(image: File.open(File.join(Rails.root, "spec/factories/images/people_3.jpg")))

				event.build_address.tap do |address|
					address.name = Faker::Company.name
					address.address_1 = Faker::Address.street_address
					address.zipcode = Faker::Address.zip
					address.city = Faker::Address.city
					address.country = Faker::Address.country
				end
				
				event.save

			end
		end

		Lab.create(title: "Fresh Living Lab", starts_at: "01/11/2015 10:00", ends_at: "31/12/2015 10:00", published: true)
		Lab.create(title: "Makers Lab", starts_at: "01/02/2016 10:00", ends_at: "31/03/2016 10:00", published: true)
		Lab.create(title: "Future Material Lab", starts_at: "01/05/2016 10:00", ends_at: "31/06/2016 10:00", published: true)

		PersonalProfile.new.tap do |profile|
			profile.title = "Guillaume Charny-Brunet"
			profile.location = "Berlin, Germany"
			profile.description = "Spacon&X is located in the heart of Copenhagen. A space for exploration and inspiration rooted in the idea that together we can co-create a better everyday life for the many people."
			profile.build_image_attachment(image: File.open(File.join(Rails.root, "spec/factories/images/people_1.jpg")))
			profile.published = true
			profile.save
		end
  end
end