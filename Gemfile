source 'https://rubygems.org'

ruby "2.2.1"

gem 'rails', '4.2.0'
gem 'pg'
gem 'puma'
gem "rack-timeout"

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'annotate'
gem 'bootstrap-sass', '~> 3.3.5'
gem "font-awesome-rails"

# Datepicker gems
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'

# Summernote
gem 'summernote-rails'
gem 'codemirror-rails'

gem 'omniauth-facebook'
gem 'omniauth-linkedin-oauth2'

# Image upload
gem 'carrierwave'
gem 'carrierwave-base64'
gem 'fog', "~> 1.28.0"
gem 'mini_magick'

# Fetch oembed info from vimeo and yutube
gem 'ruby-oembed'

# External api comm - e.g. instagram
gem 'httparty'

# This is for app_wide settings
gem "deep_merge", :require => 'deep_merge/rails_compat'

gem 'faker'

gem 'will_paginate', '~> 3.0.6'

# Forms
gem 'simple_form'
gem 'remotipart', '~> 1.2'

gem 'mandrill-api'

# Search
gem 'ransack'

# Jquery UI
gem 'jquery-ui-rails'

# Geocode
gem 'geocoder'

# Exceptions
gem 'exception_notification'

gem 'jquery-turbolinks'

gem 'friendly_id', '~> 5.1.0'

gem 'meta-tags'

gem 'bullet', group: :development
gem 'rack-mini-profiler', group: :development

gem 'pg_search'

gem 'parse-ruby-client'

gem 'newrelic_rpm'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
	gem 'guard'
	gem 'guard-rspec'
  gem "spring", "1.6.2"
  gem "spring-commands-rspec"
	gem 'rspec-rails'
	gem 'capybara'
	gem 'capybara-webkit'
	gem 'factory_girl_rails'
	gem 'database_cleaner'
	gem 'shoulda-matchers'
  gem 'pry-rails'
  gem "pry-byebug"
  gem "rails_best_practices", "1.15.7", require: false
end

