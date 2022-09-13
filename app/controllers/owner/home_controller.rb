class Owner::HomeController < ApplicationController
  before_action :authenticate_user!, only: [:start_build_property]
  
  def index 
  end

  def start_build_property 
    @property = current_user.properties.build(status: :initialize)
    @property.save
    redirect_to owner_property_build_property_index_path(property_id: @property.id)
  end
end
