Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: 'email', info_fields: 'email,name,first_name,last_name,location,birthday,gender', display: 'page', secure_image_url: true, image_size: 'large'
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'], scope: 'r_basicprofile r_emailaddress', fields: ['id', 'email-address', 'first-name', 'last-name', 'headline', 'location', 'industry', 'picture-url', 'public-profile-url', "picture-urls::(original)"], secure_image_url: true, image_size: 'large'
end