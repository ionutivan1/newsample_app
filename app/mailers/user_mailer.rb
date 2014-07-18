class UserMailer < ActionMailer::Base
  default from: "mail@railstutorial.org"

  def welcome_mail(user)
    @user = user
<<<<<<< HEAD
=======
    @url = "localhost:3000/signin"

>>>>>>> Notifications extension
    mail(to: @user.email, subject: "welcome to railstutorial.org")
  end

  def follow_notification (user)
    @user = user
<<<<<<< HEAD
    @url = users_url
    mail(to: @user.email, subject: "You gained a new follower")
  end
  
  def message_notification (user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "You received a message")
  end
=======
    # weird?
    @url = "localhost:3000/users/"
    mail(to: @user.email, subject: "You gained a new follower")
  end
>>>>>>> Notifications extension

end
