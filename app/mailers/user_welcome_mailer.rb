class UserWelcomeMailer < ApplicationMailer
  default from: ENV['DEFAULT_FROM_EMAIL']

  def user_welcome_email(user)
    @user = user
    mail(to: @user.email, subject: t('mails.user_welcome.subject'), template_name: :user_welcome_mail)
  end
end
