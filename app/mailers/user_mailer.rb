class UserMailer < ActionMailer::Base
  default from: "mail@railstutorial.org"

  def welcome_mail(user)
    @user = user
    @url = "localhost:3000/signin"

    mail(to: @user.email, subject: "welcome to railstutorial.org")
  end

  def follow_notification (user)
    @user = user
    # weird?
    @url = "localhost:3000/users/"
    mail(to: @user.email, subject: "You gained a new follower")
  end

end
