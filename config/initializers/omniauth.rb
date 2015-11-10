Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: 'email', info_fields: 'email,name,first_name,last_name', display: 'page', secure_image_url: true, image_size: 'large'
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'], scope: 'r_basicprofile r_emailaddress'
end