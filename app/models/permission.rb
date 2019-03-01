class Permission
  include UserHelper

  # Method which happens upon creation of Permission.
  # Uses DSL to state which lists of controllers and actions are allowed
  def initialize(user)
    allow :sessions, [:new, :create, :destroy]
    allow [:decisions, :circles], :index
    if user
      allow_all if super?(user)
      allow [:decisions, :circles], [:new, :create]
      allow :decisions, [:edit, :update, :destroy] do |decision|
        circles_user_involved_in = []
        Circle.all.each do |circle|
          role = Role.find_by(circle: circle, user: user)
          unless role.role_type == "none"
            circles_user_involved_in.push(circle)
          end
        end
        decision.circle.in?(circles_user_involved_in)
      end
      allow :circles, [:edit, :update]
      allow :circles, :destroy do |circle|
        circle.decisions.count == 0
      end
      allow :users, [:edit, :update, :destroy] do |user_record|
        user_record == user
      end
    end
  end

  # Method which creates @allowed_actions hash.
  # Key is list comprised of [controller, action] and value is true.
  # (nonexistant lists are falsey)
  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        # If a block is present, set the @allowed_action hash value equal to the block result.
        # If no block present, set equal to true
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  # This method checks the @allowed_actions list for allowed value pairs.
  # The method that is used in Application Controller, Views, and Specs
  def allow? (controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end


  def allow_all
    @allow_all = true
  end

private

  # def super?(user)
  #   user.site_admin_type == 'super'
  # end

end

# def circle_contains_decisions?
#   @circle.decisions.count > 0
# end

# def leader?
#   site_admin_type == 'leader'
# end
