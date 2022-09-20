class Admin::ReservationsController < ApplicationController
  def show
    @reservations = Reservation.includes(:user, :property).where(property_id: params[:id])
  end
end
