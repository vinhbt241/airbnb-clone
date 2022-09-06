class Owner::BuildPropertyController < Owner::BaseController
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
    
    case step
    when :add_images 
      @property.images.attach(params[:property][:images])
    else
      @property.update(property_params)
    end
    
    render_wizard @property 
  end

  def create
    @property = Property.create
    redirect_to wizard_path(steps.first, property_id: @property.id)
  end

  private 

  def property_params 
    params.require(:property).permit(:street, :city, :state, :country, :headline, :description, :status)
  end
end
