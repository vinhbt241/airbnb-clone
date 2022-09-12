class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @reservations = current_user.reservations 
  end

  def new 
    @reservation = Reservation.new(
      property_id: params[:property_id], 
      from: params[:from],
      to: params[:to]
    )

    @date_ranges = []
    Property.find(params[:property_id]).reservations.each do |reservation|
      @date_ranges << ["#{reservation.from}", "#{reservation.to}"]
    end
  end

  def create 
    @reservation = Reservation.new(reservation_params)

    if @reservation.save 
      @property = Property.find(params[:property_id])
      current_user.set_payment_processor :stripe
      current_user.payment_processor.customer 

      @checkout_session = current_user.payment_processor.checkout(
        mode: "payment",
        line_items: "#{@property.price_id}",
        success_url: "http://localhost:3000#{reservations_path}",
        cancel_url: "http://localhost:3000#{property_path(@property)}"
      )
    else
      render :new, status: :unprocessable_entity
    end
  end

  private 

  def reservation_params 
    params.permit(:user_id, :property_id, :from, :to, :status)
  end

end
