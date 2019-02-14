class DecisionsController < ApplicationController
  before_action :block_public_viewer, only: [:new]
  helper_method :sort_column, :sort_direction

  def index
    if searching?
      @decisions = Decision.name_description_search(params[:search])
    else
      @decisions = Decision.order(sort_column + " " + sort_direction)
    end
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
    # TODO: Remove following lines from controller
    @decision.date_decided = Date.strptime(decision_params["date_decided"], '%m/%d/%Y')
    # TODO: Make following conditional ternary
    if @decision.review_by_date
      @decision.review_by_date = Date.strptime(decision_params["review_by_date"], '%m/%d/%Y')
    else
      @decision.review_by_date = nil
    end
    if @decision.save
      flash[:notice] = "Decision successfully added!"
      redirect_to decisions_path # TODO: Should probably direct to that added decision OR the new_decision_path so user can add another (if go this route, make flash more noticeable)
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
