module FormHelper

  # This method should display ensure that each user has the exact number of roles as there are circles
  def setup_user(user)
    user_circles = []
    user.roles.each { |role| user_circles.push(role.circle) }
    remaining_circles = Circle.all - user_circles
    remaining_circles.each do |circle|
      user.roles.new(circle: circle)
    end
    user
  end
end
