class DecisionsController < ApplicationController
  before_action :authorize, only: [:new]
  before_action :authorize_admins, only: [:new]
  def unincorporated

  end

  def index
    @decisions = Decision.order(params[:sort])
  end

  def show
    @decision = Decision.find(params[:id])
  end

  def new
    @circles = Circle.all

  end
end
