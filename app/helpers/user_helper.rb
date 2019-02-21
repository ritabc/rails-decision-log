module UserHelper
  def super?(current_user)
    current_user && current_user.site_admin_type == "super"
  end
end
