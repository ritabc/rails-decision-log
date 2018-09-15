class AdminController < ApplicationController
  before_action :authorize_admin
  
end
