class DecisionsController < ApplicationController

  def unincorporated

  end

  def index
    @decisions = Decision.all
  end
end
