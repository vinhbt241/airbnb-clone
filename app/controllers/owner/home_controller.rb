class Owner::HomeController < ApplicationController
  before_action :authenticate_user!, only: [:start_build_property]
  
  def index 
  end

  def start_build_property 
    if current_user.profile.identification_image.attached?
      @property = current_user.properties.build(status: :initialize)
      @property.save
      redirect_to owner_property_build_property_index_path(property_id: @property.id)
    else
      redirect_to edit_profile_path(current_user.profile)
    end
  end
end
