class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  helper_method :current_user, :currently_super_admin?
  before_action :authorize
  delegate :allow?, to: :current_permission
  helper_method :allow?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def currently_super_admin?
    if !current_user && !(current_user.site_admin_type == 'super')
      flash[:alert] = "You aren't authorized to visit that page"
      redirect_to '/'
    else
      true
    end
  end

private

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    unless current_permission.allow?(params[:controller], params[:action], current_resource)
      store_location # Sessions helper that remembers original request url
      flash[:alert] = "You aren't authorized to visit that page"
      redirect_to signin_path
    end
  end

end
