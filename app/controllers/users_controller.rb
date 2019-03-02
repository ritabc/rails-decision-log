class UsersController < ApplicationController
  before_action :associate_super_admin_with_all_circles, only: [:create, :update]

  def index
    @users = User.all
  end

  def show
    @user = current_resource
  end

  def new
    @user = User.new
    @circles = Circle.all
    @roles = @user.roles.build # Necessary??
  end

  def create
    @user = User.new(regular_user_params)
    if @user.save
      flash[:notice] = "User successfully added!"
      redirect_to users_path
    else
      flash[:alert] = "Please try again - no user was added"
      redirect_to new_user_path
    end
  end

  def edit
    @user = current_resource
    @circles = Circle.all
    @roles = Role.where(user_id: @user.id)
  end

  def update
    @user = current_resource
    bool_array =[]
    bool_array.push(@user.update(regular_user_params))
    unless user_roles_params["roles_attributes"].nil?
      user_roles_params["roles_attributes"].each do |param|
        role_id = param[1]["id"].to_i
        circle_id = param[1]["circle_id"].to_i
        role_type = param[1]["role_type"]
        bool = Role.find(role_id).update(circle_id: circle_id, role_type: role_type)
        bool_array.push(bool)
      end
    end
    unless bool_array.include?(false)
      flash[:notice] = "User successfully updated!"
      redirect_to super?(current_user) ? users_path : root_path 
    else
      flash[:alert] = "Please try again - user was not updated"
      redirect_to edit_user_path
    end
  end

private

  def regular_user_params
    params.require(:user).permit(:first_name, :last_initial, :password, :password_confirmation, :email, :site_admin_type)
  end

  def user_roles_params
    params.require(:user).permit(:roles_attributes => [:id, :role_type, :circle_id, :id])
  end

  def current_resource
    @current_resource ||= User.find(params[:id]) if params[:id]
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
