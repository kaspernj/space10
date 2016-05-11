require "mandrill"

class BaseMandrillMailer < ActionMailer::Base
  default(
    from: "Space10 <hello@space10.io>"
  )

  private

  def send_mail(email, subject, body)
    mail(to: email, subject: subject, body: body, content_type: "text/html")
  end

  def mandrill_template(template_name, attributes)
    if ENV["MANDRILL_PASSWORD"].present?
      api_key = ENV["MANDRILL_PASSWORD"]
    elsif Rails.application.secrets.mandrill
      api_key = Rails.application.secrets.mandrill.fetch("api_key")
    else
      raise "Could not figure out the API key"
    end

    mandrill = Mandrill::API.new(api_key)

    merge_vars = attributes.map do |key, value|
      { name: key, content: value }
    end

    mandrill.templates.render(template_name, [], merge_vars)["html"]
  end
end