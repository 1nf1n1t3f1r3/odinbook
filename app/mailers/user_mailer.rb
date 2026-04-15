require "sendgrid-ruby"
include SendGrid

class UserMailer < ApplicationMailer
  def welcome_email(user)
  Rails.logger.info "📧 MAILER STARTED for #{user.email}"

  from = SendGrid::Email.new(email: "1nf1n1t3f1r3@gmail.com")
  to = SendGrid::Email.new(email: user.email)
  subject = "Welcome to Odinbook!"
  content = SendGrid::Content.new(
    type: "text/html",
    value: "<h1>Welcome #{user.username}!</h1><p>Glad you're here 🎉</p>"
  )

  mail = SendGrid::Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
  response = sg.client.mail._("send").post(request_body: mail.to_json)

  Rails.logger.info "📬 SendGrid status: #{response.status_code}"
  Rails.logger.info "📬 SendGrid body: #{response.body}"
  Rails.logger.info response.headers
  end
end
