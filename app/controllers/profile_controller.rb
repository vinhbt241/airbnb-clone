class ProfileController < ApplicationController
  def edit  
    @profile = Profile.find(params[:id])
  end
  
  def update 
    @profile = Profile.find(params[:id])

    @profile.update(profile_params)

    redirect_to owner_start_build_property_path
  end

  private 

  def profile_params 
    params.require(:profile).permit(:identification_image)
  end
end
