class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.generate_token(:password_reset_token)
      user.password_reset_sent_at = Time.zone.now
      if user.save
        UserMailer.password_reset(user).deliver
      end
    end
    # user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update 
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:notice] = 'Password reset has expired'
      redirect_to new_password_reset_path
    elsif @user.update(reset_params)
      flash[:notice] = "Password has been reset!"
      redirect_to signin_path
    else
      render :edit
    end
  end

  private
  def reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
