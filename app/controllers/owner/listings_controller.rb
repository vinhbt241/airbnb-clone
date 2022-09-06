class Owner::ListingsController < Owner::BaseController  
  def index 
    @listings = current_user.properties
  end
end
