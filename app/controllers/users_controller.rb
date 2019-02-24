class UsersController < ApplicationController
  before_action :associate_super_admin_with_all_circles, only: [:create, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @circles = Circle.all
    @roles = @user.roles.build # Necessary??
  end

  def create
    @user = User.new(user_params)

    # Assign site_admin_type
    if params["user"]["site_admin_type"] == "0"
      @user.site_admin_type = "leader"
    elsif params["user"]["site_admin_type"] == "1"
      @user.site_admin_type == "super"
    end

    # Assign roles, if any
    circles = Circle.all
    roles = []
    circles.each do |circle|
      role_type = params["#{circle.abbreviation}"]
      unless role_type == "none"
        role = Role.new(role_type: role_type, user: @user, circle: circle)
        roles.push(role)
      end
    end
    # push roles into @user.roles
    if @user.save && roles.each { |role| role.save }
      binding.pry
      flash[:notice] = "User successfully added!"
      redirect to '/'
    else
      binding.pry
      flash[:alert] = "Please try again - no user was added"
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
    @circles = Circle.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User successfully updated!"
      redirect_to '/'
    else
      binding.pry
      flash[:alert] = "Please try again - user was not updated"
      redirect_to edit_decision_path
    end
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_initial, :email, :site_admin_type, roles: [:role_type, :circle_id])
  end

  def current_resource
    @current_resource ||= Decision.find(params[:id]) if params[:id]
  end

  def associate_super_admin_with_all_circles
    if super?(current_resource) # TODO: If current_resource is super!
      circles = Circle.all
      circles.each do |circle|
        Role.new(role_type: "admin", circle: circle, user: current_user)
      end
    end
  end
end
