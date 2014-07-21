class UserMailer < ActionMailer::Base
  default from: "mail@railstutorial.org"

  def welcome_mail(user)
    @user = user
    @url = users_url+"/#{user.id}/set_complete/#{user.confirmation}"

    mail(to: @user.email, subject: "welcome to railstutorial.org")
  end

  def follow_notification (user)
    @user = user
    @url = users_url
    mail(to: @user.email, subject: "You gained a new follower")
  end

end
