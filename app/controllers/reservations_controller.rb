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
    Property.find(params[:property_id]).reservations.where(status: "success").each do |reservation|
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
        metadata: {
          user_id: @reservation.user.id,
          property_id: @reservation.property.id,
          from: @reservation.from, 
          to: @reservation.to
        },
        success_path: reservation_success_path, 
        cancel_path: property_path(@property)
      )
    else
      render :new, status: :unprocessable_entity
    end
  end

  def success 
    session_info = Stripe::Checkout::Session.retrieve(params[:session_id])

    property = Property.find(session_info[:metadata][:property_id])
    active_reservations = property.reservations.where(status: "success")

    date_range_overlaped = active_reservations.any? do |active_reservation|
      active_reservation.date_range_overlap?(session_info[:metadata][:from], session_info[:metadata][:to])
    end

    
    Reservation.create(
      user_id: session_info[:metadata][:user_id],
      property_id: session_info[:metadata][:property_id],
      from: session_info[:metadata][:from],
      to: session_info[:metadata][:to],
      status: date_range_overlaped ? "failure" : "processing" 
    )
  end

  private 

  def reservation_params 
    params.permit(:user_id, :property_id, :from, :to, :status)
  end

end
