class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :currently_super_admin?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def currently_super_admin?
    if !current_user && !(current_user.admin_type == 'super')
      flash[:alert] = "You aren't authorized to visit that page"
      redirect_to '/'
    end
  end

  def block_public_viewer
    if !current_user
      store_location # Sessions helper that remembers original request url
      flash[:alert] = "You aren't authorized to visit that page"
      redirect_to signin_path
    end
  end
end
