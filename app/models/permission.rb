class Permission
  include MiscHelper

  # Method which happens upon creation of Permission.
  # Uses DSL to state which lists of controllers and actions are allowed
  def initialize(user)

    # Anyone
    allow :sessions, [:new, :create, :destroy]
    allow :circles, :index
    allow :decisions, [:all, :review]
    allow :circle_decisions, :index
    allow :password_resets, [:index, :create, :new, :edit, :update, :show, :destroy]

    # If They're logged in
    if user
      allow :users, :show do |user_record|
        user_record == user
      end

      # If they're logged in as a super
      if super?(user)
        allow :users, [:index]
        allow [:users, :decisions], [:new, :create, :edit, :update, :destroy]
        allow :circles, [:new, :create, :edit, :update]
        allow :circles, :destroy do |circle|
          circle_has_no_decisions?(circle)
        end

      # If they're logged in as a leader
      else
        allow :decisions, :new
        allow :decisions, :create # TODO: Find way to prevent users unassociated with the decisions circles to create decisions. For now, the view only allows them to select associated circles
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
        allow :users, [:edit, :update] do |user_record|
          user_record == user
        end
        allow :users, :destroy do |user_record|
          user_record == user
        end
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
    allowed && (allowed == true || (resource && allowed.call(resource)))
  end


  def allow_all
    @allow_all = true
  end
end
