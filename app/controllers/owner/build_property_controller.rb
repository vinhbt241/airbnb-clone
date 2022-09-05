class Owner::BuildPropertyController < ApplicationController
  include Wicked::Wizard

  steps :add_address, :add_images, :add_headline, :add_description

  def show
    @property = Property.find(params[:property_id])
    render_wizard
  end

  def update
    @property = Property.find(params[:property_id])
    params[:property][:status] = step.to_s
    params[:property][:status] = 'active' if step == steps.last
    
    @property.update(property_params)
    render_wizard @property 
  end

  def create
    @property = Property.create
    redirect_to wizard_path(steps.first, property_id: @property.id)
  end

  private 

  def property_params 
    params.require(:property).permit(:headline, :description, :street, :city, :state, :country, :status)
  end
end
