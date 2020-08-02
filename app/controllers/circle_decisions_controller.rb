class CircleDecisionsController < ApplicationController
  def index
    @circles = Circle.order(:id)
    @circle = Circle.find_by(id: circle_decision_params[:circle_id])
    @decisions = @circle.decisions.order(date_decided: :desc)
  end

private

  def circle_decision_params
    params.permit(:circle_id)
  end
end
