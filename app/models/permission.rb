class Permission

  # Method which happens upon creation of Permission.
  # Uses DSL to state which lists of controllers and actions are allowed
  def initialize(user)
    allow :sessions, [:new, :create, :destroy]
    allow [:decisions, :circles], :index
    if user
      allow_all
    end
  end

  # Method which creates @allowed_actions hash.
  # Key is list comprised of [controller, action] and value is true.
  # (nonexistant lists are falsey)
  def allow(controllers, actions)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = true
      end
    end
  end

  # This method checks the @allowed_actions list for allowed value pairs.
  # The method that is used in Application Controller, Views, and Specs
  def allow? (controller, action)
    # return true if controller == "sessions"
    # return true if controller.in?(%w[circles decisions]) && action == "index"
    # return true if user
    # false
    @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
  end


  def allow_all
    @allow_all = true
  end



private

end

# def allow?(controller, action)
#   return true if controller == "sessions"
#   return true if controller == "decisions" && action == "index"
#
#   if user # if user is logged in...
#     return true if controller == "decisions" && action == "new"
#     if user.super? # ...and if they're super
#       return true if controller == "decisions"
#     elsif user.leader? # ...otherwise if they're a leader...
#       # if decision_belongs_to_circle_user_involved_in? # ...then are they associated with the circle?
#         return true if controller == "decisions"
#       # end
#     else
#       return false
#     end
#   end
#
#   false
# end

# def circle_contains_decisions?
#   @circle.decisions.count > 0
# end

# def decision_belongs_to_circle_user_involved_in? # Alias: decision_and_user_associated_with_same_circle?
#   @decision.circle.in?(@user.circles)
# end
