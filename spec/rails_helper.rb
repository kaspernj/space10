ENV["RAILS_ENV"] = "test"

require File.expand_path("../../config/environment", __FILE__)
abort("DATABASE_URL environment variable is set") if ENV["DATABASE_URL"]

require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }

OmniAuth.config.test_mode = true

Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:each) do
    ActionMailer::Base.deliveries.clear
  end
  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include ActionView::Helpers::TranslationHelper
end

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
end

ActiveRecord::Migration.maintain_test_schema!
