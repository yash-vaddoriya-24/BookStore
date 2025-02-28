class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email.subject
  #
  default from: "yashvaddoriya120@gmail.com"
  def welcome_email(user)
    @user = user
    # @url = "http://example.com/login"
    attachments.inline["download (4).jpeg"] = File.read("app/assets/images/download (4).jpeg")
    mail(to: @user.email, subject: "Welcome to My Awesome Site")
  end
end
