class UserMailer < ActionMailer::Base
  default from: "mail@railstutorial.org"


  def message_notification (user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "You received a message")
  end

end
