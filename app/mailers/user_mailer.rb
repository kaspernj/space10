class UserMailer < BaseMandrillMailer
  def welcome(user_id)
    user = User.find(user_id)
    subject = "Welcome to Space 10!"
    merge_vars = {
      "FNAME" => user.name
    }
    body = mandrill_template("Transactional: Welcome email", merge_vars)

    send_mail(user.email, subject, body)
  end

  def confirm_registration(user_id, event_id)
    user = User.find(user_id)
    event = Event.find(event_id)
    subject = "Your registration has been confirmed"
    merge_vars = {
      "FNAME" => user.name,
      "EVENT_TITLE" => event.title,
      "EVENT_STARTS_AT" => event.starts_at.to_s(:formatted),
      "EVENT_ENDS_AT" => event.ends_at.try('to_s(:formatted)'),
      "EVENT_ADDRESS" => event.address.try('html_address'),
      "EVENT_URL" => event_url(event)
    }
    body = mandrill_template("Transactional: Event confirmation", merge_vars)

    send_mail(user.email, subject, body)
  end
end