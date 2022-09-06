class Owner::HomeController < ApplicationController
  def index 
  end

  def start_build_property 
    @property = Property.create(status: "")
    redirect_to owner_property_build_property_index_path(property_id: @property.id)
  end
end
