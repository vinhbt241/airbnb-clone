class Owner::HomeController < ApplicationController
  before_action :authenticate_user!, only: [:start_build_property]
  
  def index 
  end

  def start_build_property 
    if current_user
      @property = current_user.properties.build(status: "")
      @property.save
      redirect_to owner_property_build_property_index_path(property_id: @property.id)
    else
      redirect_to new_user_session_path
    end
  end
end
