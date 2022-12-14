class Owner::BuildPropertyController < Owner::BaseController
  include Wicked::Wizard

  steps :add_address, :add_images, :add_headline, :add_description, :add_price

  def show
    @property = Property.find(params[:property_id])
    authorize @property
    render_wizard
  end

  def update
    @property = Property.find(params[:property_id])
    authorize @property

    params[:property][:status] = step.to_s
    params[:property][:status] = 'pending' if step == steps.last
    
    @property.update(property_params)

    render_wizard @property 
  end

  def create
    @property = Property.create(status: :initialize)
    redirect_to wizard_path(steps.first, property_id: @property.id)
  end

  private 

  def property_params 
    params.require(:property).permit(:street, :city, :state, :country,:headline, :description, :status, :price, images: [])
  end

end
