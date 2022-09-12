class Owner::BuildPropertyController < Owner::BaseController
  include Wicked::Wizard

  steps :add_address, :add_images, :add_headline, :add_description

  def show
    @property = Property.find(params[:property_id])
    unless current_user.has_role?(:admin) || @property.owner.id == current_user.id 
      redirect_to root_path
    else
      render_wizard
    end
  end

  def update
    @property = Property.find(params[:property_id])
    unless current_user.has_role?(:admin) || @property.owner.id == current_user.id  
      redirect_to root_path
    else
      params[:property][:status] = step.to_s
      params[:property][:status] = 'pending' if step == steps.last
      
      case step
      when :add_images 
        @property.images.attach(params[:property][:images])
      else
        @property.update(property_params)
      end
      
      render_wizard @property 
    end
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
