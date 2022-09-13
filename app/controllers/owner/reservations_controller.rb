class Owner::ReservationsController < ApplicationController
  def index
    @property = Property.find(params[:property_id]) 
    @reservations = @property.reservations
  end

  def update
    @reservation = Reservation.find(params[:id])
    @property = @reservation.property
    @other_reservations = @property.reservations.where(status: "success")
    
    date_range_overlaped = @other_reservations.any? do |other_reservation|
      other_reservation.date_range_overlap?(@reservation.from, @reservation.to)
    end

    unless date_range_overlaped 
      @reservation.update(status:"success")
      redirect_to owner_property_reservations_path(property_id: @property.id)
    else  
      puts "Range overlapped"
    end
  end
end
