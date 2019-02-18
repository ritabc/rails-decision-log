class Permission < Struct.new(:user) # Inherit from Struct so can pass in user
  def allow?(controller, action)
    return true if controller == "sessions"
    return true if controller == "decisions" && action == "index"
    if user # if we're logged in, we'll pass a user to the new Permission
      if user.leader?
      elsif user.super?
      end
    end

    false
  end
end
