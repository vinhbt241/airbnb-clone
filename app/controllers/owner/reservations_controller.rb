class Owner::ReservationsController < ApplicationController
  def index
    @property = Property.find(params[:property_id]) 
    @reservations = @property.reservations
  end

  def update
    @reservation = Reservation.find(params[:id])

    @reservation.update(status:"success")
    redirect_to owner_property_reservations_path(property_id: @reservation.property.id)
  end
end
