class Admin::ReservationsController < ApplicationController
  def show
    @reservations = Reservation.where(property_id: params[:id])
  end
end
