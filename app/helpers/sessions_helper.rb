module SessionsHelper
  # Stores the URL trying to be accessed
  def store_location
    if request.get?
      session[:forwarding_url] = request.original_url
    end
  end

  # Redirects to stored location (or to the default)
  def redirect_back_or
    redirect_to(session[:forwarding_url] || root_url)
    session.delete(:forwarding_url)
  end
end
