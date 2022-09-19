class Owner::ReservationsController < ApplicationController
  def index
    @property = Property.find(params[:property_id]) 
    @reservations = @property.reservations
  end

  def update
    @reservation = Reservation.find(params[:id])

    property = @reservation.property
    active_reservations = property.reservations.where(status: "success")
    date_range_overlaped = active_reservations.any? do |active_reservation|
      active_reservation.date_range_overlap?(@reservation.from, @reservation.to)
    end

    unless date_range_overlaped
      @reservation.update(status:"success")

      ReservationMailer.with(reservation: @reservation).reservation_success_email.deliver_later

      notifications_to_mark_as_read = @reservation.notifications_as_reservation.where(recipient: current_user)
      notifications_to_mark_as_read.each do |notification|
        notification.mark_as_read!
      end

      redirect_to owner_property_reservations_path(property_id: @reservation.property.id)
    else
      puts "Error!"
    end
  end
end
