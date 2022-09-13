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

    if @reservation.valid?
      @property = Property.find(params[:property_id])
      
      @checkout_session = Payment::StripePayment.checkout_reservation(
        user: current_user, 
        property: @property, 
        success_path: reservations_path, 
        cancel_path: property_path(@property)
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
