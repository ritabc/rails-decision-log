class UserHasOneRolePerCircle < ActiveModel::Validator

  def validate(user)
    # users_circle_names = []
    # user.roles.each do |role|
    #   binding.pry
    #   circle_name ||=
    #   users_circle_names.push(role.circle.name)
    # end
    # # if its valid (has no duplicates), it will be nill
    # unless users_circle_names.detect { |circle_name| users_circle_names.count(circle_name) > 1 } == nil
    #   user.errors[:roles] << "User must have only one role per circle"
    # end
  end
end
