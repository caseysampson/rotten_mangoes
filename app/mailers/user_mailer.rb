class UserMailer < ActionMailer::Base
  
  default from: "admin@rottenmangoes.com"

  def goodbye_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your account has been deleted')
  end

end
