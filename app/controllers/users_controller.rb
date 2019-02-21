class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
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
end
