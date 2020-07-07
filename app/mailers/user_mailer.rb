class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Common Ground Decision Log Password Reset"
  end
end
