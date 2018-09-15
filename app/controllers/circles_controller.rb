class CirclesController < ApplicationController
  def index
    @circles = Circle.all
  end
end
