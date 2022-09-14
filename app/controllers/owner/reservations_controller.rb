class Owner::ReservationsController < ApplicationController
  def index
    @property = Property.find(params[:property_id]) 
    @reservations = @property.reservations
  end

  def update
    @reservation = Reservation.find(params[:id])

    @reservation.update(status:"success")

    ReservationMailer.with(reservation: @reservation).reservation_success_email.deliver_later

    redirect_to owner_property_reservations_path(property_id: @reservation.property.id)
  end
end
