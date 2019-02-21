class UsersController < ApplicationController
  before_action :associate_super_admin_with_all_circles, only: [:create, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @circles = Circle.all
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
      flash[:alert] = "Please try again - user was not updated"
      redirect_to edit_decision_path
    end
  end

private

  def user_params
    params.require(:user).permit(:fisrt_name, :last_initial, :email, :site_admin_type)
  end

  def associate_super_admin_with_all_circles
    if super?(current_user)
      circles = Circle.all
      circles.each do |circle|
        Role.new(site_admin_type: "admin", circle: circle, user: current_user)
      end
    end
  end
end
