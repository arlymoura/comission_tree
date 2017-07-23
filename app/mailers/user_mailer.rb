class UserMailer < ApplicationMailer
  default from: "arlymoura@gmail.com"

  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Confime Sua Conta"
  end
end
