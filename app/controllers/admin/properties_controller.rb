class Admin::PropertiesController < ApplicationController
  def index 
    @pending_properties = Property.where(status: "pending")
    @properties = Property.where.not(status: "pending")
  end

  def edit 
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])

    if @property.update(property_params)
      redirect_to admin_properties_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private 
  
  def property_params 
    params.require(:property).permit(:status)
  end
end
