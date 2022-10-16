class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @reservations = current_user.reservations.includes(:property)
  end

  def show 
    @reservation = Reservation.find(params[:id])
    @property = @reservation.property
  end

  def new 
    @reservation = Reservation.new(
      property_id: params[:property_id], 
      from: params[:from],
      to: params[:to]
    )

    @property = Property.find(params[:property_id])

    @date_ranges = []
    @property.reservations.where(status: "success").each do |reservation|
      @date_ranges << ["#{reservation.from}", "#{reservation.to}"]
    end
  end

  def create 
    @reservation = Reservation.new(reservation_params)
    @property = Property.find(params[:property_id])
    
    active_reservations = @property.reservations.where(status: "success")
    date_range_overlaped = active_reservations.any? do |active_reservation|
      active_reservation.date_range_overlap?(@reservation.from, @reservation.to)
    end

    if date_range_overlaped == true
      flash.alert = "Reservation's date range is overlapped, refresh the page to see new avalaible days"
      render :new, status: :unprocessable_entity 
      return
    end

    if @reservation.valid?
      @checkout_session = Payment::StripePayment.checkout_reservation(
        user: current_user,
        property: @property, 
        date_range: (@reservation.to - @reservation.from).to_i,
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
      active_reservation.date_range_overlap?(session_info[:metadata][:from].to_datetime, session_info[:metadata][:to].to_datetime)
    end
    
    reservation = Reservation.create(
      user_id: session_info[:metadata][:user_id],
      property_id: session_info[:metadata][:property_id],
      from: session_info[:metadata][:from],
      to: session_info[:metadata][:to],
      payment_intent: session_info[:payment_intent],
      status: date_range_overlaped ? "failure" : "processing" 
    )

    ReservationMailer.with(reservation: reservation).reservation_created_email.deliver_later

    ActionCable.server.broadcast("notification_#{property.owner.id}", {action: "increase", message: "Property at #{property.city} has been reserved", property_id: property.id})
  end

  private 

  def reservation_params 
    params.permit(:user_id, :property_id, :from, :to, :status)
  end

end
