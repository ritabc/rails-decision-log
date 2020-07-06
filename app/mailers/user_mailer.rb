class UserMailer < ApplicationMailer
  default from: "cgdl@NOREPLY.com"
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Common Ground Decision Log Password Reset"
  end
end
