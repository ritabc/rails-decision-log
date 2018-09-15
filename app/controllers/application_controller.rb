class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def authorize_admins
    if (current_user.admin_type != 'admin') && (current_user.admin_type != 'super')
      flash[:alert] = "You aren't authorized to visit that page"
      redirect_to '/'
    end
  end
end
