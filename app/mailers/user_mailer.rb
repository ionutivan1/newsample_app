class UserMailer < ActionMailer::Base
  default from: "mail@railstutorial.org"

  def welcome_mail(user)
    @user = user
    mail(to: @user.email, subject: "welcome to railstutorial.org")
  end

  def follow_notification (user)
    @user = user
    @url = users_url
    mail(to: @user.email, subject: "You gained a new follower")
  end

  def password_reset (user)
    @user = user
    mail(to: @user.email, subject: "Password reset")
  end
end
