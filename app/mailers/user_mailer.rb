class UserMailer < ActionMailer::Base
  default from: "mail@railstutorial.org"


  def message_notification (user)
    @user = user
    @url = notifications_url
    mail(to: @user.email, subject: "You received a message")
  end

end
