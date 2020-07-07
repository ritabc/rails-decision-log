class UserHasOneRolePerCircle < ActiveModel::Validator

  def validate(user)
    users_circle_ids = []
    user.roles.each do |role|
      users_circle_ids.push(role.circle.id)
    end
    # if its valid (has no duplicates), it will be nill
    # If one of the circles exists more than once in user_circle_ids, add an error
    # But don't error if user_circle_ids is empty
    unless users_circle_ids.detect { |circle_name| users_circle_ids.count(circle_name) > 1 } == nil
      binding.pry
      user.errors[:roles] << "User must have only one role per circle"
    end
  end
end
