class CircleDecisionsController < ApplicationController
  def index
    @circle = Circle.find_by(id: circle_decision_params[:circle_id])
    @decisions = @circle.decisions
  end

private

  def circle_decision_params
    params.permit(:circle_id)
  end
end
