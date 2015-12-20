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

  def password_reset(user_id)
    user = User.find(user_id)
    subject = "Password reset instructions"
    merge_vars = {
      "FNAME" => user.first_name,
      "PASSWORD_RESET_URL" => edit_password_reset_url(user.password_reset_token)
    }
    body = mandrill_template("Transactional: Reset password", merge_vars)

    send_mail(user.email, subject, body)
  end

  def send_message(message, sender_id)
    message = message
    recipient = Profile.find(message.recipient)
    sender = User.find(sender_id)

    subject = "#{sender.first_name} sent you a message"
    merge_vars = {
      "FNAME" => recipient.title,
      "SENDER_NAME" => sender.name,
      "MESSAGE_BODY" => message.body.gsub(/\n/, '<br/>').html_safe
    }
    body = mandrill_template("Transactional: Message received", merge_vars)

    mail(to: recipient.email, from: "#{sender.first_name} via Space10 <no-reply@space10.io>", reply_to: "#{sender.first_name} <#{sender.email}>", subject: subject, body: body, content_type: "text/html")
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
    body = mandrill_template("Transactional: Confirmed registration", merge_vars)

    send_mail(user.email, subject, body)
  end

  def waiting_registration(user_id, event_id)
    user = User.find(user_id)
    event = Event.find(event_id)
    subject = "You are on waitlist"
    merge_vars = {
      "FNAME" => user.name,
      "EVENT_TITLE" => event.title,
      "EVENT_STARTS_AT" => event.starts_at.to_s(:formatted),
      "EVENT_ENDS_AT" => event.ends_at.try('to_s(:formatted)'),
      "EVENT_ADDRESS" => event.address.try('html_address'),
      "EVENT_URL" => event_url(event)
    }
    body = mandrill_template("Transactional: Waitlisted registration", merge_vars)

    send_mail(user.email, subject, body)
  end

  def unconfirmed_registration(user_id, event_id)
    user = User.find(user_id)
    event = Event.find(event_id)
    subject = "You are awaiting confirmation"
    merge_vars = {
      "FNAME" => user.name,
      "EVENT_TITLE" => event.title,
      "EVENT_STARTS_AT" => event.starts_at.to_s(:formatted),
      "EVENT_ENDS_AT" => event.ends_at.try('to_s(:formatted)'),
      "EVENT_ADDRESS" => event.address.try('html_address'),
      "EVENT_URL" => event_url(event)
    }
    body = mandrill_template("Transactional: Unconfirmed registration", merge_vars)

    send_mail(user.email, subject, body)
  end
end