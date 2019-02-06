class SessionsController < ApplicationController

  def create
    @user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if @user
      flash[:notice] = "You've signed in."
      session[:user_id] = @user.id
      redirect_back_or ## later should go to page depending on where they came from
                      ## If just logging in and user is super, go to admin page
    else
      flash[:alert] = "There was a problem signing in. Please try again"
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've signed out."
    redirect_to '/'
  end
end
