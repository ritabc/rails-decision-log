class DecisionsController < ApplicationController
  before_action :authorize, only: [:new]
  before_action :authorize_admins, only: [:new]
  helper_method :sort_column, :sort_direction

  def index
    @decisions = Decision.order(sort_column + " " + sort_direction)
  end

  def show
    @decision = Decision.find(params[:id])
  end

  def new
    @circles = Circle.all
    @decision = Decision.new
  end

  def create
    @decision = Decision.new(decision_params)
    if @decision.save
      flash[:notice] = "Decision successfully added!"
      redirect_to decisions_path
    else
      flash[:alert] = "Please try again - no decision was added"
      redirect_to new_decision_path
    end
  end


private

  def decision_params
    params.require(:decision).permit(:name, :date_decided, :circle_id, :description, :review_by_date, :supp_doc_one_link, :supp_doc_one_type, :supp_doc_two_link, :supp_doc_two_type)
  end

  def sort_column
    %w[name circle_id date_decided].include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    ["asc", "desc"].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
