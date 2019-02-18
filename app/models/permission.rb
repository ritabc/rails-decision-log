class Permission
  attr_reader(:user, :circle, :decision)

  def initialize(attributes)
    @user = attributes.fetch(:user)
    @circle = attributes.fetch(:circle)
    @decision = attributes.fetch(:decision)
  end

  ## Authorizes. Does NOT account for whether user is associated with circle
  # TODO: Refactor when Done with all 'Modules' (Decisions/Circles,Users), and either organize by module, ie controller at top of nesting, or reflext organization of permission_spec.rb
  def allow?(controller, action)
    return true if controller == "sessions"
    return true if controller == "decisions" && action == "index"

    if user # if user is logged in...
      if user.super? # ...and if they're super
        return true if controller == "decisions"
      elsif user.leader? # ...otherwise if they're a leader...
        if decision_belongs_to_circle_user_involved_in? # ...then are they associated with the circle?
          return true if controller == "decisions"
        end
      else
        return false
      end
    end

    false
  end

  def decision_belongs_to_circle_user_involved_in? # Alias: decision_and_user_associated_with_same_circle?
    @decision.circle.in?(@user.circles)
  end

private

  def circle_contains_decisions?
    @circle.decisions.count > 0
  end

end