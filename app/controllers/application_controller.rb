class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :currently_super_admin?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id]) ## DOES THIS RETURN CURRENT USER?? If not, how can we call this method and say 'if current_user'?
    end
  end

  def currently_super_admin?
    if !current_user && !(current_user.admin_type == 'super')
      flash[:alert] = "You aren't authorized to visit that page"
      redirect_to '/'
    end
  end

  def authorize
    if !current_user
      flash[:alert] = "You aren't authorized to visit that page"
      redirect_to '/'
    end
  end

  def authorize_admins
    if (current_user.admin_type != 'admin') && (current_user.admin_type != 'super')
      flash[:alert] = "You aren't authorized to visit that page"
      redirect_to '/'
    end
  end

  # def authorize_super
  #   if (current_user.admin_type != 'super')
  #     flash[:alert] = "You aren't authoriezed to visit that page"
  #     redirect_to '/'
  #   end
  # end
end
