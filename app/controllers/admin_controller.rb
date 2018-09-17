class AdminController < ApplicationController
  before_action :authorize_admin
  before_action :authorize_super, only: [:index]

end
