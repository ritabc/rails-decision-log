class Permission
  attr_reader(:user, :circle, :decision)

  def initialize(attributes)
    @user = attributes.fetch(:user)
    @circle = attributes.fetch(:circle)
    @decision = attributes.fetch(:decision)
  end

  ## Authorizes. Does NOT account for whether user is associated with circle
  def allow?(controller, action) # TODO: Refactor when Done with all 'Modules' (Decisions/Circles,Users), and either organize by module, ie controller at top of nesting, or reflext organization of permission_spec.rb
    return true if controller == "sessions"
    return true if controller == "decisions" && action == "index"

    if user # if user is logged in...
      if user.super? # ...and if they're super
        return true if controller == "decisions"
      elsif user.leader? # ...otherwise if they're a leader
        return true if controller == "decisions"
      else
        return false
      end
    end

    false
  end

  def decision_belongs_to_circle_user_involved_in? # Alias: decision_and_user_associated_with_same_circle?
    binding.pry
    @decision.circle.in?(@user.circles)
  end

private

  def circle_contains_decisions?
    @circle.decisions.count > 0
  end

end
