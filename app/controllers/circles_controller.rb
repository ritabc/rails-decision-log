class CirclesController < ApplicationController
  def index
    @circles = Circle.all
  end

  def new
    @circle = Circle.new
  end

  def create
    @circle = Circle.new(circle_params)
    if @circle.save
      flash[:notice] = "Circle successfully added!"
      redirect_to circles_path
    else
      flash[:alert] = "Please try again - no circle was added."
      redirect_to new_circle_path
    end
  end

  def edit
    @circle = Circle.find(params[:id])
  end

  def update ## TODO: Also need to be able to update roles
    @circle = User.find(params[:id])
    if @circle.update(circle_params)
      flash[:notice] = "User successfully updated!"
      redirect_to '/'
    else
      flash[:alert] = "Please try again - circle was not updated"
      redirect_to edit_decision_path
    end
  end

private

  def circle_params
    params.require(:circle).permit(:name, :description, :abbreviation)
  end

end
