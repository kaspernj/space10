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
end