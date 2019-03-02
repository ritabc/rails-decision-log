module MiscHelper
  def super?(current_user)
    current_user && current_user.site_admin_type == "super"
  end

  def circle_has_no_decisions?(circle)
    circle.decisions.count == 0
  end
end
