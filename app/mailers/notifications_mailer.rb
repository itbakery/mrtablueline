class NotificationsMailer < ActionMailer::Base
  default from: "no-reply@mrta-blueline.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.new_message.subject
  #
  # @recipients = @admin_recipients + @author_recipients
  # mail to: emails
  def new_message(obj)
    @obj = obj
    @admin_recipients = User.role_users(:admin).map(&:email)
    @author_recipients = User.role_users(:author).map(&:email)
    @recipients = @admin_recipients
    emails = @recipients.join(",")
    m = ["rhcsa2012@gmail.com","sawangpongm@gmail.com"].join(",")
    mail to: m
  end
end
