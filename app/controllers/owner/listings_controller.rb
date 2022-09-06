class Owner::ListingsController < ApplicationController
  before_action :authenticate_user!
  
  def index 
    @listings = current_user.properties
  end
end
