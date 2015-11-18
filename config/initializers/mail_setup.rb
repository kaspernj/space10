# Change mail delvery to either :smtp, :sendmail, :file, :test
ActionMailer::Base.delivery_method = :smtp unless Rails.env.test?
ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => ENV["MANDRILL_USERNAME"],
    :password  => ENV["MANDRILL_PASSWORD"], # SMTP password is any valid API key
    :authentication => 'plain' # Mandrill supports 'plain' or 'login'
    # :domain => 'wishlistt.com', # your domain to identify your server when connecting
}

ActionMailer::Base.default_url_options = {
      host: "localhost:3000",
    } if Rails.env.development?

ActionMailer::Base.default_url_options = {
      host: "space10-staging.herokuapp.com"
    } if Rails.env.staging?

ActionMailer::Base.default_url_options = {
      host: "www.space10.io"
    } if Rails.env.production?

ActionMailer::Base.default_url_options = {
      host: "www.space10.io"
    } if Rails.env.test?
