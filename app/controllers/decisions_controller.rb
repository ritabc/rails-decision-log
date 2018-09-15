class DecisionsController < ApplicationController

  def unincorporated

  end

  def index
    @decisions = Decision.all
  end

  def show
    @decision = Decision.find(params[:id])
  end
end
