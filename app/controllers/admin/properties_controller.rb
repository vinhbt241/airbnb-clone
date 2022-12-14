class Admin::PropertiesController < ApplicationController
  def index 
    properties = Property.includes(:owner)
    @pending_properties = properties.where(status: "pending")
    @properties = properties.where.not(status: "pending")
  end

  def edit 
    @property = Property.includes(images_attachments: :blob).find(params[:id])
  end

  def update
    @property = Property.find(params[:id])

    if @property.update(property_params)
      #Create product on Stripe
      if @property.product_id.blank? 
        product = Stripe::Product.create({
          name: @property.headline
        })

        price = Stripe::Price.create({
          unit_amount: @property.price * 100,
          currency: 'usd',
          product: product.id,
        })
  
        @property.product_id = product.id
        @property.price_id = price.id
        @property.save
      end

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
