class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :currently_super_admin?
  helper_method :searching?

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
    # if (current_user.admin_type != 'admin') && (current_user.admin_type != 'super')
    if !current_user
      store_location # Sessions helper that remembers original request url
      flash[:alert] = "You aren't authorized to visit that page"
      redirect_to signin_path
    end
  end

  # Helper method for sort/search toggle. To be used in both views AND controllers
  def searching?
    params[:search] && !params[:search].empty?
  end

  # def authorize_super
  # end
end
